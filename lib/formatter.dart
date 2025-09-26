import 'package:flutter/services.dart';

/// Formats input to: +998 (XX) XXX-XX-XX
class UzbekPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), ''); // only numbers

    if (digits.length > 12) digits = digits.substring(0, 12);

    String formatted = '+';
    for (int i = 0; i < digits.length; i++) {
      final ch = digits[i];
      if (i == 0) {
        formatted += ch; // country code first digit
      } else if (i == 2) {
        formatted += digits[1]; // second digit of country code
      } else if (i == 2) {
        formatted += digits[1];
      }
    }
    // A cleaner version:
    // +998 (XX) XXX-XX-XX
    if (digits.isNotEmpty) {
      formatted = '+998';
      if (digits.length > 3) {
        formatted += ' (${digits.substring(3, digits.length.clamp(3, 5))}';
      }
    }

    // But easier is to use pattern below:
    final buffer = StringBuffer();
    if (digits.isNotEmpty) buffer.write('+998 ');
    if (digits.length > 3)
      buffer.write('(${digits.substring(3, digits.length.clamp(3, 5))}) ');

    return TextEditingValue(
      text: _formatUzbek(digits),
      selection: TextSelection.collapsed(offset: _formatUzbek(digits).length),
    );
  }
}

/// Helper to format to +998 (XX) XXX-XX-XX
String _formatUzbek(String digits) {
  // ensure starting with 998
  if (!digits.startsWith('998')) {
    if (digits.startsWith('9'))
      digits = '998' + digits.substring(1);
    else
      digits = '998' + digits;
  }
  // Remove country code for grouping
  String rest = digits.substring(3);
  final buffer = StringBuffer('+998');
  if (rest.isNotEmpty)
    buffer.write(' (${rest.substring(0, rest.length.clamp(0, 2))}');
  if (rest.length > 2)
    buffer.write(') ${rest.substring(2, rest.length.clamp(2, 5))}');
  if (rest.length > 5)
    buffer.write('-${rest.substring(5, rest.length.clamp(5, 7))}');
  if (rest.length > 7)
    buffer.write('-${rest.substring(7, rest.length.clamp(7, 9))}');
  return buffer.toString();
}
