import 'package:flutter/material.dart';

class SalaryDetails extends StatelessWidget {
  const SalaryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageTitleWidget(title: 'Maosh hisoboti'),
          SizedBox(height: 16),
          DateRangeWidget(),
          SizedBox(height: 20),
          SalaryInfoCard(),
          SizedBox(height: 16),
          WorkScheduleCard(
            title: '1-smena',
            amount: "112,600 so'm",
            leftLabel: 'Ishladi',
            rightLabel: 'Kechikdi',
            leftValue: '15 Soat 8 daqiqa',
            rightValue: '0 soat 0 daqiqa',
          ),
          SizedBox(height: 12),
          WorkScheduleCard(
            title: '2-smena',
            amount: "112,600 so'm",
            leftLabel: 'Ishladi',
            rightLabel: 'Kechikdi',
            leftValue: '15 Soat 8 daqiqa',
            rightValue: '0 soat 0 daqiqa',
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Page Title Widget
class PageTitleWidget extends StatelessWidget {
  final String title;

  const PageTitleWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}

// Date Range Widget
class DateRangeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DatePickerButton(date: '01-09-2025 08:10'),
        SizedBox(width: 12),
        DatePickerButton(date: '10-09-2025 18:10'),
      ],
    );
  }
}

// Date Picker Button Widget
class DatePickerButton extends StatelessWidget {
  final String date;

  const DatePickerButton({required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
          SizedBox(width: 6),
          Text(date, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

// Salary Info Card Widget
class SalaryInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SalaryAmountSection(),
          SizedBox(height: 20),
          SalaryChangesSection(),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          WorkScheduleHeaderSection(),
        ],
      ),
    );
  }
}

// Salary Amount Section Widget
class SalaryAmountSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.attach_money, color: Colors.green, size: 20),
            SizedBox(width: 8),
            Text(
              'Jami hisoblargan maosh',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "210,721 so'm",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}

// Salary Changes Section Widget
class SalaryChangesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.trending_up, color: Colors.grey[600], size: 20),
            SizedBox(width: 8),
            Text(
              "Maosh o'zgarishlari",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
        SizedBox(height: 12),
        ChangeItem(label: 'Bonus', value: '+0', color: Colors.green),
        ChangeItem(label: 'Jarima', value: '0', color: Colors.red),
        ChangeItem(label: 'Avans', value: '0', color: Colors.grey),
      ],
    );
  }
}

// Change Item Widget
class ChangeItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const ChangeItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Work Schedule Header Section Widget
class WorkScheduleHeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.shuffle, color: Colors.grey[600], size: 20),
        SizedBox(width: 8),
        Text(
          'Ish jadvali',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

// Work Schedule Card Widget
class WorkScheduleCard extends StatelessWidget {
  final String title;
  final String amount;
  final String leftLabel;
  final String rightLabel;
  final String leftValue;
  final String rightValue;

  const WorkScheduleCard({
    required this.title,
    required this.amount,
    required this.leftLabel,
    required this.rightLabel,
    required this.leftValue,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScheduleHeaderRow(title: title, amount: amount),
          SizedBox(height: 12),
          ScheduleStatsRow(
            leftLabel: leftLabel,
            rightLabel: rightLabel,
            leftValue: leftValue,
            rightValue: rightValue,
          ),
        ],
      ),
    );
  }
}

// Schedule Header Row Widget
class ScheduleHeaderRow extends StatelessWidget {
  final String title;
  final String amount;

  const ScheduleHeaderRow({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// Schedule Stats Row Widget
class ScheduleStatsRow extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;
  final String leftValue;
  final String rightValue;

  const ScheduleStatsRow({
    required this.leftLabel,
    required this.rightLabel,
    required this.leftValue,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ScheduleStatItem(
            icon: Icons.access_time,
            label: leftLabel,
            value: leftValue,
            color: Colors.blue,
          ),
        ),
        Expanded(
          child: ScheduleStatItem(
            icon: Icons.trending_down,
            label: rightLabel,
            value: rightValue,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

// Schedule Stat Item Widget
class ScheduleStatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const ScheduleStatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            SizedBox(width: 6),
            Text(label, style: TextStyle(fontSize: 12, color: color)),
          ],
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
