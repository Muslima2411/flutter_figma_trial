import 'package:flutter/material.dart';
import 'package:flutter_figma_trial/staff/face_verification_page.dart';
import 'package:flutter_figma_trial/staff/profile_details/attendance_table.dart';
import 'package:flutter_figma_trial/staff/profile_details/profile_header.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({super.key});

  @override
  State<StaffHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<StaffHomePage> {
  bool hasArrivedToday = false;
  bool hasLeftToday = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Profile Header
          ProfileHeader(),
          // Attendance Table
          AttendanceTable(),
          // const SizedBox(height: 100), // Space for FAB
        ],
      ),
      floatingActionButton: buildDynamicFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildDynamicFAB() {
    // Determine button state based on attendance
    String buttonText;
    Color buttonColor;
    IconData buttonIcon;
    VoidCallback onPressed;

    if (!hasArrivedToday) {
      // Show "Ishga keldim" button
      buttonText = "Ishga keldim";
      buttonColor = const Color(0xFF0F766E); // Teal color like in image
      buttonIcon = Icons.login;
      onPressed = _handleArrival;
    } else if (!hasLeftToday) {
      // Show "Ishdan chiqdim" button
      buttonText = "Ishdan chiqdim";
      buttonColor = Colors.orange;
      buttonIcon = Icons.logout;
      onPressed = _handleDeparture;
    } else {
      // Work day completed
      buttonText = "Ish kuni tugallandi";
      buttonColor = Colors.grey;
      buttonIcon = Icons.check_circle;
      onPressed = () {}; // Disabled
    }

    return Container(
      width: MediaQuery.of(context).size.width - 32,
      height: 56,
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(buttonIcon, size: 24),
            const SizedBox(width: 12),
            Text(
              buttonText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void _handleArrival() {
    setState(() {
      hasArrivedToday = true;
    });

    // Here you would typically:
    // 1. Send arrival time to your backend
    // 2. Update local storage
    // 3. Show confirmation message

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Kelganingiz qayd etildi!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _handleDeparture() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => FaceVerificationPage()),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ketganingiz qayd etildi!'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
