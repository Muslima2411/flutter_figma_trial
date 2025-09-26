import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage> {
  String selectedLanguage = "O'zbekcha";
  List<String> languages = ["O'zbekcha", "English", "Русский"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Top cyan section with profile image
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFF00BCD4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: MediaQuery.of(context).size.width / 2 - 40,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://via.placeholder.com/80x80/8B7355/FFFFFF?text=AG',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Color(0xFF8B7355),
                          child: Center(
                            child: Text(
                              'AG',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Profile info section
          Container(
            padding: EdgeInsets.only(top: 40, left: 24, right: 24),
            child: Column(
              children: [
                Text(
                  'Azazmazing Guy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Dasturchi',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 32),

                // Phone number
                _buildInfoRow(Icons.phone_outlined, '+99893 935 0321'),
                SizedBox(height: 16),

                // Date 1
                _buildInfoRow(
                  Icons.calendar_today_outlined,
                  '01-08-2025 08:16',
                ),
                SizedBox(height: 16),

                // Date 2
                _buildInfoRow(Icons.access_time_outlined, '04-09-2025 17:03'),
                SizedBox(height: 40),

                // Language expansion tile
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.language,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    title: Text(
                      selectedLanguage,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey[600],
                    ),
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    children: languages.map((language) {
                      return ListTile(
                        title: Text(
                          language,
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedLanguage == language
                                ? Color(0xFF2D5A5A)
                                : Colors.black,
                            fontWeight: selectedLanguage == language
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedLanguage = language;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          Spacer(),

          // Bottom button
          Container(
            padding: EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout or other action
                  print('Ishga keldim pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D5A5A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Ishga keldim',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        SizedBox(width: 16),
        Text(text, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
      ],
    );
  }
}
