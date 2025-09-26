import 'package:flutter/material.dart';
import 'package:flutter_figma_trial/staff/info_details/additional_details.dart';
import 'package:flutter_figma_trial/staff/info_details/attendance_details.dart';
import 'package:flutter_figma_trial/staff/info_details/salary_details.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoPage> with TickerProviderStateMixin {
  PageController pageController = PageController();
  int currentTabIndex = 0;

  List<String> tabTitles = ["Maosh Tavsilotlari", "Davomat", "Qo'shimchalar"];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(),
            TabButtonsWidget(
              tabTitles: tabTitles,
              currentTabIndex: currentTabIndex,
              onTabTapped: onTabTapped,
            ),
            SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentTabIndex = index;
                  });
                },
                children: [
                  SalaryDetails(),
                  AttendanceDetails(),
                  AdditionalDetails(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Header Widget
class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        "Ma'lumotlar paneli",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}

// Tab Buttons Widget
class TabButtonsWidget extends StatelessWidget {
  final List<String> tabTitles;
  final int currentTabIndex;
  final Function(int) onTabTapped;

  const TabButtonsWidget({
    required this.tabTitles,
    required this.currentTabIndex,
    required this.onTabTapped,
  });

  IconData _getTabIcon(int index) {
    switch (index) {
      case 0:
        return Icons.folder_outlined;
      case 1:
        return Icons.calendar_today_outlined;
      case 2:
        return Icons.add_circle_outline;
      default:
        return Icons.circle_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(tabTitles.length, (index) {
          bool isActive = currentTabIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabTapped(index),
              child: Container(
                margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: isActive ? Color(0xFFFFA726) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isActive ? Color(0xFFFFA726) : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getTabIcon(index),
                      size: 16,
                      color: isActive ? Colors.white : Colors.black,
                    ),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        tabTitles[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isActive ? Colors.white : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
