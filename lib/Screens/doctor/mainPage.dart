import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:health_ai/Screens/doctor/dashboard.dart';
import 'package:health_ai/Screens/doctor/patients_handling.dart';
import 'package:health_ai/Screens/settings_screen.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = const [
    Dashboard(),
    PatientsHandling(),
    SettingsPage(),
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
              padding: EdgeInsets.all(20),
              tabs: const [
                GButton(
                  icon: Icons.local_hospital_sharp,
                  text: 'Lab Results',
                  textColor: Colors.black,
                  iconColor: Colors.black,
                ),
                GButton(
                  icon: Icons.people_alt_sharp,
                  text: 'Patients',
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
        ));
  }
}
