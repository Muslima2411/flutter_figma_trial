import 'package:flutter/material.dart';

class HolidaysPage extends StatelessWidget {
  const HolidaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    final holidays = [
      ['Yakshanba', '3,10,17,24,31'],
      ['Shanba', '5,7,9,11,19,20,22'],
      ['Juma', '5,7,9,11,19,20,22'],
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text(
          'Dam olish kunlari',
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
                label: const Text("Dam kuni qo'shish"),
                onPressed: () {
                  // TODO: navigate to holiday creation page
                },
              ),
            ),
            const SizedBox(height: 16),

            // Table
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
                  columnSpacing: 40,
                  columns: const [
                    DataColumn(
                      label: Text('№',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Dam kuni nomi',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Dam kunlari',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Amallar',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                  rows: List.generate(holidays.length, (index) {
                    final h = holidays[index];
                    return DataRow(cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(h[0])),
                      DataCell(Text(h[1])),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          onPressed: () {
                            // TODO: show actions (edit/delete)
                          },
                        ),
                      ),
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
