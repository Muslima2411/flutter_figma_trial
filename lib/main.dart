import 'package:flutter/material.dart';
import 'package:flutter_figma_trial/init_page.dart';
import 'package:flutter_figma_trial/manager/main_dashboard_page.dart';
import 'package:flutter_figma_trial/manager/manager_main_page.dart';

void main() {
  runApp(const TimePayApp());
}

class TimePayApp extends StatelessWidget {

  const TimePayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimePay',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'SF Pro Display', // Use system font
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InitPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
