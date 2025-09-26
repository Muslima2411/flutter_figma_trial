import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_figma_trial/manager/manager_main_page.dart';
import 'package:flutter_figma_trial/verification_page.dart';
import 'formatter.dart';
import 'init_page.dart';

class TimePayButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? borderColor;
  final Color? textColor;

  const TimePayButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.borderColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultBorderColor = borderColor ?? const Color(0xFF2D5A27);
    final defaultTextColor = textColor ?? const Color(0xFF2D5A27);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isLoading ? Colors.grey[300]! : defaultBorderColor,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isLoading ? Colors.grey[400] : defaultTextColor,
                ),
              ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final UserRole userRole;

  const LoginPage({super.key, required this.userRole});

  @override
  State<LoginPage> createState() => _TimePayLoginPageState();
}

class _TimePayLoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isManager = widget.userRole == UserRole.manager;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                _buildHeader(),
                const SizedBox(height: 48),

                /// Conditionally show fields
                if (isManager) ...[
                  _buildUsernameField(),
                  const SizedBox(height: 20),
                  _buildPasswordField(),
                ] else ...[
                  _buildPhoneField(),
                ],

                const SizedBox(height: 32),
                _buildLoginButton(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Xush kelibsiz',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Biz bilan bog\'lanish',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return _labeledField(
      label: 'Foydalanuvchi nomi',
      child: TextFormField(
        controller: _usernameController,
        keyboardType: TextInputType.text,
        decoration: _inputDecoration('Foydalanuvchi nomini kiriting'),
        validator: _validateUsername,
      ),
    );
  }

  Widget _buildPasswordField() {
    return _labeledField(
      label: 'Parol',
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        decoration: _inputDecoration(
          'Foydalanuvchi parolini kiriting',
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey[400],
            ),
            onPressed: () =>
                setState(() => _isPasswordVisible = !_isPasswordVisible),
          ),
        ),
        validator: _validatePassword,
      ),
    );
  }

  Widget _buildPhoneField() {
    return _labeledField(
      label: 'Telefon raqami',
      child: TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          UzbekPhoneFormatter(), // ← auto-format here
        ],
        decoration: _inputDecoration('+998 (XX) XXX-XX-XX'),
        validator: _validatePhone,
      ),
    );
  }

  Widget _labeledField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  InputDecoration _inputDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2D5A27), width: 2),
      ),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildLoginButton() {
    return TimePayButton(
      text: 'Davom et',
      onPressed: _handleLogin,
      isLoading: _isLoading,
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Foydalanuvchi nomini kiriting';
    if (value.length < 3) return 'Kamida 3 ta belgi bo\'lishi kerak';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Parolni kiriting';
    if (value.length < 6) return 'Parol kamida 6 ta belgi bo\'lishi kerak';
    return null;
  }

  String? _validatePhone(String? value) {
    final digits = value?.replaceAll(RegExp(r'\D'), '') ?? '';
    if (digits.length != 12) return 'To‘liq telefon raqamini kiriting';
    return null;
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (widget.userRole == UserRole.manager) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ManagerMainPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const VerificationPage()),
        );
      }
    } catch (error) {
      _showErrorMessage(error.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Xatolik: $message'), backgroundColor: Colors.red),
    );
  }
}
