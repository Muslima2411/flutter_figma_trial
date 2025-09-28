import 'package:flutter/material.dart';

class AttendanceTable extends StatelessWidget {
  const AttendanceTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
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
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
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
