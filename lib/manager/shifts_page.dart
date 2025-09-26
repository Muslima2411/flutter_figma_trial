import 'package:flutter/material.dart';

class ShiftsPage extends StatelessWidget {
  const ShiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final shifts = [
      ['Smena 8 dan 18 gacha', '08:00', '18:00'],
      ['Smena 8 dan 19 gacha', '08:00', '19:00'],
      ['Smena 8 dan 15 gacha', '08:00', '18:00'],
      ['Tungi smena', '19:00', '08:00'],
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text(
          'Smenalar',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
   body: Padding(
        padding: const EdgeInsets.all(16), // overall page padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Smena yaratish'),
                onPressed: () {
                  // TODO: navigate to shift creation page
                },
              ),
            ),
            const SizedBox(height: 16),

            // Table fills available width but keeps 16 px padding
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor:
                      MaterialStateProperty.all(Colors.grey.shade100),
                  columnSpacing: 80,
                  columns: const [
                    DataColumn(
                      label: Text('№',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Smena nomi',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Ish vaqti',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                  rows: List.generate(shifts.length, (index) {
                    final s = shifts[index];
                    return DataRow(cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(s[0])),
                      DataCell(Row(
                        children: [
                          Text(s[1]),
                          const SizedBox(width: 8),
                          const Icon(Icons.swap_horiz, size: 16),
                          const SizedBox(width: 8),
                          Text(s[2]),
                        ],
                      )),
                    ]);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}