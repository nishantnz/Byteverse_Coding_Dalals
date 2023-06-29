import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:healthai/features/homepage/doctor/screens/doctor_dashboard.dart';
import 'package:healthai/features/homepage/doctor/screens/doctor_all_scan_pages.dart';
import 'package:healthai/features/profile/screens/doctor/doctor_settings_screen.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});
  static const routeName = '/doctor-home-page';
  @override
  State<DoctorHomePage> createState() => _DoctorMainPageState();
}

class _DoctorMainPageState extends State<DoctorHomePage> {
  List pages = [
    const DoctorDashboard(),
    const DoctorAllScanPages(),
    const DoctorSettingsPage(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.purple[900],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
            selectedIndex: _selectedIndex,
            backgroundColor: Colors.purple[900] as Color,
            color: Colors.white,
            //activeColor: Colors.white,
            gap: 8,
            tabBackgroundColor: Colors.purple[200] as Color,
            padding: const EdgeInsets.all(20),
            tabs: const [
              GButton(
                icon: Icons.dashboard_sharp,
                text: 'Dashboard',
                textColor: Colors.black,
                iconColor: Colors.black,
              ),
              GButton(
                icon: Icons.people_alt_sharp,
                text: 'History',
                textColor: Colors.black,
                iconColor: Colors.black,
              ),
              GButton(
                icon: Icons.settings_outlined,
                text: 'Settings',
                textColor: Colors.black,
                iconColor: Colors.black,
              ),
            ],
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
