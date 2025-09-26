import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_figma_trial/staff/staff_main_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController _pinController = TextEditingController();
  Timer? timer;
  int remainingSeconds = 57;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _pinController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        t.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void verifyCode(String code) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Code verified: $code')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Authentication',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Please enter the code that we sent to your\ntelegram account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                formatTime(remainingSeconds),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),

              /// --- PinCodeFields replaces the manual 4 TextFields ---
              PinCodeTextField(
                appContext: context,
                length: 4,
                controller: _pinController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                cursorColor: Colors.black,
                obscuringWidget: const Icon(
                  Icons.circle,
                  size: 14,
                  color: Color(0xFF2D5A5A),
                ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 60,
                  fieldWidth: 60,
                  activeColor: const Color(0xFFF0F4F8),
                  selectedColor: const Color(0xFFF0F4F8),
                  inactiveColor: const Color(0xFFF0F4F8),
                  activeFillColor: const Color(0xFFF0F4F8),
                  selectedFillColor: const Color(0xFFF0F4F8),
                  inactiveFillColor: const Color(0xFFF0F4F8),
                ),
                enableActiveFill: true,
                onChanged: (_) {}, // called on every digit
                onCompleted: verifyCode, // called when 4 digits entered
              ),

              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() => remainingSeconds = 57);
                  startTimer();
                },
                child: Text(
                  "Didn't receive the code?",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 80),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_pinController.text.length == 4) {
                      verifyCode(_pinController.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (c) => (StaffMainPage())),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D5A5A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
