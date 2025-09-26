import 'package:flutter/material.dart';

class BreaksPage extends StatelessWidget {
  const BreaksPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example break data. Replace with your real list or Bloc/Provider data.
    final List<Map<String, String>> breaks = [
      {'name': 'Obed 1', 'start': '12:00', 'end': '13:00'},
      {'name': 'Tanaffus', 'start': '16:15', 'end': '16:45'},
      {'name': 'Obed 2', 'start': '22:00', 'end': '22:30'},
      {'name': 'Tanaffus', 'start': '01:15', 'end': '01:45'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Tanaffuslar',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.shade800,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  // TODO: Add your add break action
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  "Tanaffus qo'shish",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Table
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(
                  Colors.grey.shade200,
                ),
                columnSpacing: 24,
                horizontalMargin: 12,
                columns: const [
                  DataColumn(
                    label: Text(
                      '№',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Tanaffus nomi',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Vaqt davomiyligi',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                rows: List.generate(breaks.length, (index) {
                  final b = breaks[index];
                  return DataRow(
                    cells: [
                      DataCell(Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.black),
                      )),
                      DataCell(Text(
                        b['name'] ?? '',
                        style: const TextStyle(color: Colors.black),
                      )),
                      DataCell(Row(
                        children: [
                          Text(
                            b['start'] ?? '',
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_right_alt,
                              size: 18, color: Colors.black),
                          const SizedBox(width: 4),
                          Text(
                            b['end'] ?? '',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
