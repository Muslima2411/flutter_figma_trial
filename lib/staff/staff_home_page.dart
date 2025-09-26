import 'package:flutter/material.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({super.key});

  @override
  State<StaffHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<StaffHomePage> {
  bool hasArrivedToday =
      false; // This would come from your backend/state management
  bool hasLeftToday = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            child: Column(
              children: [
                // Profile Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                  ),
                  child: Icon(Icons.person_2_rounded),
                ),
                const SizedBox(height: 12),
                // Name
                const Text(
                  'Azamazing Guy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                // Position
                Text(
                  'Dasturchi',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                // Title
                const Text(
                  'Oylik kirish/chiqish jadvali',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Attendance Table
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 1),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'N°',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Keldi',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Ketdi',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Scrollable table body
                  Expanded(
                    child: ListView.builder(
                      itemCount: 31,
                      itemBuilder: (context, index) {
                        final dayNumber = index + 1;
                        return _buildTableRow(dayNumber, index == 30);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100), // Space for FAB
        ],
      ),
      floatingActionButton: _buildDynamicFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildDynamicFAB() {
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

  Widget _buildTableRow(int dayNumber, bool isLastRow) {
    final scheduleData = _getScheduleData();
    final dayData = scheduleData[dayNumber];

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: isLastRow
              ? BorderSide.none
              : BorderSide(color: Colors.grey[300]!, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: [
            // Day number
            Expanded(
              flex: 1,
              child: Text(
                dayNumber.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Arrival time
            Expanded(
              flex: 2,
              child: _buildTimeChip(
                dayData?['arrival'],
                dayData?['arrivalColor'] ?? Colors.red,
                dayData?['arrivalDiff'],
              ),
            ),
            // Departure time
            Expanded(
              flex: 2,
              child: _buildTimeChip(
                dayData?['departure'],
                dayData?['departureColor'] ?? Colors.red,
                dayData?['departureDiff'],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip(String? time, Color color, String? difference) {
    if (time == null) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          SizedBox(
            height: 32,
            child: Center(
              child: Text(
                '--:--',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Text(
            '--:--:--',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          difference ?? '--:--:--',
          style: TextStyle(
            color: _getDifferenceColor(color),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Color _getDifferenceColor(Color chipColor) {
    if (chipColor == Colors.green) return Colors.green;
    if (chipColor == Colors.orange) return Colors.orange;
    if (chipColor == Colors.pink) return Colors.pink;
    return Colors.red;
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
    setState(() {
      hasLeftToday = true;
    });

    // Here you would typically:
    // 1. Send departure time to your backend
    // 2. Update local storage
    // 3. Show confirmation message

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ketganingiz qayd etildi!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Map<int, Map<String, dynamic>> _getScheduleData() {
    return {
      1: {
        'arrival': '07:47',
        'arrivalColor': Colors.green,
        'arrivalDiff': '00:23:35',
        'departure': '17:21',
        'departureColor': Colors.green,
        'departureDiff': '00:23:35',
      },
      2: {
        'arrival': '07:47',
        'arrivalColor': Colors.green,
        'arrivalDiff': '00:23:35',
        'departure': '17:21',
        'departureColor': Colors.green,
        'departureDiff': '00:23:35',
      },
      3: {
        'arrival': '07:47',
        'arrivalColor': Colors.green,
        'arrivalDiff': '00:23:35',
        'departure': '17:21',
        'departureColor': Colors.green,
        'departureDiff': '00:23:35',
      },
      4: {
        'arrival': '07:47',
        'arrivalColor': Colors.green,
        'arrivalDiff': '00:23:35',
        'departure': '17:21',
        'departureColor': Colors.green,
        'departureDiff': '00:23:35',
      },
      5: {
        'arrival': '08:20',
        'arrivalColor': Colors.orange,
        'arrivalDiff': '-00:20:35',
        'departure': '17:21',
        'departureColor': Colors.green,
        'departureDiff': '00:23:35',
      },
      6: {
        'arrival': '07:47',
        'arrivalColor': Colors.green,
        'arrivalDiff': '00:23:35',
        'departure': '17:21',
        'departureColor': Colors.green,
        'departureDiff': '00:23:35',
      },
      7: {
        'arrival': '07:47',
        'arrivalColor': Colors.green,
        'arrivalDiff': '00:23:35',
        'departure': '16:56',
        'departureColor': Colors.pink,
        'departureDiff': '-00:04:35',
      },
    };
  }
}
