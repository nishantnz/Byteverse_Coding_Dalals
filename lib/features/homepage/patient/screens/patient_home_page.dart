import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:healthai/features/homepage/patient/screens/patient_dashboard.dart';
import 'package:healthai/features/homepage/patient/screens/patients_history.dart';
import 'package:healthai/features/profile/screens/patient/patient_settings_screen.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});
  static const routeName = '/patient-home-page';
  @override
  State<PatientHomePage> createState() => _PatientMainPageState();
}

class _PatientMainPageState extends State<PatientHomePage> {
  List pages = [
    const PatientDashboard(),
    const PatientsHistoryPage(),
    const PatientSettingsPage(),
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
