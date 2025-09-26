import 'package:flutter/material.dart';

class AdditionalDetails extends StatelessWidget {
  const AdditionalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          padding: const EdgeInsets.all(12.0),
          child: const Text(
            'Qo\'shimchalar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        // Horizontal scrollable table
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.grey[50]),
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 14,
            ),
            dataTextStyle: const TextStyle(color: Colors.black87, fontSize: 13),
            columnSpacing: 20,
            horizontalMargin: 16,
            headingRowHeight: 50,
            dataRowHeight: 48,
            columns: const [
              DataColumn(label: Text('N°')),
              DataColumn(label: Text('Turi')),
              DataColumn(label: Text('Miqdor')),
              DataColumn(label: Text('Sana')),
              DataColumn(label: Text('Izoh')),
            ],
            rows: _getTableData().map((data) {
              return DataRow(
                cells: [
                  DataCell(Text(data['number']!)),
                  DataCell(Text(data['type']!)),
                  DataCell(Text(data['amount']!)),
                  DataCell(Text(data['date']!)),
                  DataCell(Text(data['comment']!)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  List<Map<String, String>> _getTableData() {
    return [
      {
        'number': '1',
        'type': 'KPI',
        'amount': '100 000',
        'date': '01-09-2025',
        'comment': 'Qo\'shimcha bir nimaalaaar',
      },
      {
        'number': '2',
        'type': 'Jarima',
        'amount': '20 000',
        'date': '02-09-2025',
        'comment': 'Formasiz kelish bu juda qattiq yoooomon ish',
      },
      {
        'number': '3',
        'type': 'Avans',
        'amount': '400 000',
        'date': '05-09-2025',
        'comment': 'Qarzi bor ekan deb hafa qivurmela odammi',
      },
      {
        'number': '4',
        'type': 'KPI',
        'amount': '20 000',
        'date': '04-09-2025',
        'comment': 'Qo\'shimcha malumotla kere bosa tel qivurila',
      },
    ];
  }
}
