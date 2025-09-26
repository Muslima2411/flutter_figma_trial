import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_figma_trial/login_page.dart';

// Enum for user roles
enum UserRole { manager, employee }

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              _buildLogo(),
              const SizedBox(height: 60),
              _buildContent(),
              const Spacer(flex: 2),
              _buildButtons(context),
              const SizedBox(height: 32),
            ],
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
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Orange clock icon
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.access_time, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 8),
        // Digital head with pixels
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Color(0xFF2D5A27), // Dark green
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // Pixel pattern
              Positioned(
                top: 8,
                right: 8,
                child: Column(
                  children: List.generate(
                    3,
                    (i) => Row(
                      children: List.generate(
                        3,
                        (j) => Container(
                          width: 3,
                          height: 3,
                          margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // TIME PAY text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TIME',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D5A27),
                letterSpacing: 1.2,
              ),
            ),
            Text(
              'PAY',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Text(
          'Ro\'lni tanlang',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Boshqaruvchi yoki xodim birini tanlang va davom eting',
          style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.4),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        _buildPrimaryButton(
          isPrimary: true,
          text: 'Bo\'lim boshlig\'i',
          onPressed: () => _handleManagerRole(context),
        ),
        const SizedBox(height: 16),
        _buildPrimaryButton(
          isPrimary: false,
          text: 'Xodim',
          onPressed: () => _handleEmployeeRole(context),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton({
    required bool isPrimary,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isPrimary ? Color(0xFF2D5A27) : Colors.orange,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isPrimary ? Color(0xFF2D5A27) : Colors.orange,
          ),
        ),
      ),
    );
  }

  void _handleManagerRole(BuildContext context) {
    _navigateToLogin(context, UserRole.manager);
  }

  void _handleEmployeeRole(BuildContext context) {
    _navigateToLogin(context, UserRole.employee);
  }

  void _navigateToLogin(BuildContext context, UserRole role) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => LoginPage(userRole: role)));
  }
}
