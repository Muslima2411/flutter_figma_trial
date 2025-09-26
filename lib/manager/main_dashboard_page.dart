import 'package:flutter/material.dart';

class MainDashboardPage extends StatelessWidget {
  const MainDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text('Boshqaruv paneli'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '15-09-2025',
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        // Handle date selection
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  MaterialButton(
                    height: 30,
                    onPressed: () {},
                    color: Colors.teal,
                    textColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.download),
                        const Text('Excelga yuklab olish'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildProgressCard('Keladi', 89, 123, Colors.green),
            _buildProgressCard('Kuchdi', 24, 123, Colors.orange),
            _buildProgressCard('Kelmasdi', 34, 123, Colors.red),
            const SizedBox(height: 20),
           Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Xodimlar',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      // Filter row
      Row(
        children: [
          _buildFilterButton('(Hammasi)', true),
          const SizedBox(width: 12),
          _buildFilterButton('Oylik', false),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.sync, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                'Ma\'lumotlarni sinxronlash',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      // Table header
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 30,
              child: Text(
                'N°',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                'Ism',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            const Expanded(
              child: Text(
                'Kirish',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Expanded(
              child: Text(
                'Chiqish',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      // Staff list
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5, // Updated to show 5 items as in design
        itemBuilder: (context, index) {
          return _buildStaffRow(index + 1);
        },
      ),
    ],
  ),
),
 ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(
    String title,
    double current,
    double total,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${current.toInt()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '/${total.toInt()}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Jarayon',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${((current / total) * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: current / total,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
       ],
      ),
    );
  }

//AAAAAAAAAAAAAAAAAAAAA
}

Widget _buildFilterButton(String text, bool isSelected) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: isSelected ? Colors.grey.shade100 : Colors.transparent,
      border: Border.all(
        color: isSelected ? Colors.grey.shade400 : Colors.grey.shade300,
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        color: isSelected ? Colors.black87 : Colors.grey.shade700,
      ),
    ),
  );
}


Widget _buildStaffRow(int index) {
  final List<Map<String, dynamic>> staffData = [
    {
      'name': 'Rahimov A.',
      'id': 'ID: 012',
      'avatar': 'R',
      'entryTime': '07:32',
      'entryDuration': '00:28',
      'exitTime': '17:22',
      'exitDuration': '00:28',
      'lateness': 0, // On time
    },
    {
      'name': 'Kamolov N.',
      'id': 'ID: 018',
      'avatar': 'K',
      'entryTime': '08:45',
      'entryDuration': '-10:15', // Late less than 15 minutes
      'exitTime': '17:22',
      'exitDuration': '00:28',
      'lateness': 10, // 10 minutes late
    },
    {
      'name': 'Ruzmetov D.',
      'id': 'ID: 023',
      'avatar': 'R',
      'entryTime': '09:25',
      'entryDuration': '-25:30', // Late more than 15 minutes
      'exitTime': '17:22',
      'exitDuration': '00:28',
      'lateness': 25, // 25 minutes late
    },
    {
      'name': 'Rahimov A.',
      'id': 'ID: 012',
      'avatar': 'R',
      'entryTime': '08:10',
      'entryDuration': '-05:12', // Late less than 15 minutes
      'exitTime': '17:22',
      'exitDuration': '00:28',
      'lateness': 5, // 5 minutes late
    },
    {
      'name': 'Kamolov N.',
      'id': 'ID: 018',
      'avatar': 'K',
      'entryTime': '07:32',
      'entryDuration': '00:28',
      'exitTime': '17:22',
      'exitDuration': '00:28',
      'lateness': 0, // On time
    },
  ];

  final staff = staffData[index - 1];

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(color: Colors.grey.shade300),
        right: BorderSide(color: Colors.grey.shade300),
        bottom: BorderSide(color: Colors.grey.shade300),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 30,
          child: Text(
            '$index',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey.shade300,
                child: Text(
                  staff['avatar'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    staff['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    staff['id'],
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getTimeColor(staff['lateness']),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  staff['entryTime'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                staff['entryDuration'],
                style: TextStyle(
                  fontSize: 11,
                  color: _getTimeColor(staff['lateness']),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  staff['exitTime'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                staff['exitDuration'],
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Color _getTimeColor(int latenessInMinutes) {
  if (latenessInMinutes == 0) {
    return Colors.green; // On time
  } else if (latenessInMinutes <= 15) {
    return Colors.orange; // Late but less than 15 minutes
  } else {
    return Colors.red; // Late more than 15 minutes
  }
}