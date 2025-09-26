import 'package:flutter/material.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _positionSearchController = TextEditingController();

  // Sample staff data - you can replace this with real data
  final List<Map<String, dynamic>> staffList = List.generate(25, (index) {
    final names = [
      'Rahimov A.',
      'Kamolov N.',
      'Ruzmetov D.',
      'Abdullayev S.',
      'Nazarov M.',
    ];
    return {
      'id': 'ID: ${(index + 10).toString().padLeft(3, '0')}',
      'name': names[index % names.length],
      'avatar': names[index % names.length][0],
      'status': 'To\'g\'ri',
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text('Xodimlar jadvali'),
      ),
      body: Column(
        children: [
          // Search and Add Staff Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // First search field
                TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Qidirish...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Second search field
                TextFormField(
                  controller: _positionSearchController,
                  decoration: InputDecoration(
                    hintText: 'Lavozim bo\'yicha qidirish...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Add Staff Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add staff functionality
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      'Xodim qo\'shish',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Staff Table
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Table Header
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
                            'Rasm yaqoilligi',
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
                            'Amallar',
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
                  // Staff List
                  Expanded(
                    child: ListView.builder(
                      itemCount: staffList.length,
                      itemBuilder: (context, index) {
                        return _buildStaffRow(index + 1, staffList[index]);
                      },
                    ),
                  ),
                  // Pagination Footer
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        Text(
                          '26 dan 1-10 ko\'rsatilmoqda',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Previous page
                              },
                              icon: const Icon(Icons.chevron_left),
                              iconSize: 20,
                            ),
                            _buildPaginationButton('Oldingi', false, () {
                              // Handle previous page
                              print('Previous page pressed');
                            }),
                            const SizedBox(width: 8),
                            _buildPaginationButton('1', true, () {
                              // Handle page 1
                              print('Page 1 pressed');
                            }),
                            const SizedBox(width: 8),
                            Text(
                              '...',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(width: 8),
                            _buildPaginationButton('3', false, () {
                              // Handle page 3
                              print('Page 3 pressed');
                            }),
                            const SizedBox(width: 8),
                            _buildPaginationButton('Keyingi', false, () {
                              // Handle next page
                              print('Next page pressed');
                            }),
                            IconButton(
                              onPressed: () {
                                // Next page
                              },
                              icon: const Icon(Icons.chevron_right),
                              iconSize: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffRow(int index, Map<String, dynamic> staff) {
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
                  backgroundColor: Colors.grey.shade400,
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
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Text(
                  staff['status'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.teal.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: PopupMenuButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.grey.shade600,
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Tahrirlash'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('O\'chirish'),
                  ),
                ],
                onSelected: (value) {
                  // Handle menu actions
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationButton(String text, bool isActive, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.teal : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isActive ? Colors.teal : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.white : Colors.grey.shade700,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _positionSearchController.dispose();
    super.dispose();
  }
}