import 'package:flutter/material.dart';
import 'package:health_ai/Screens/doctorOrPatient.dart';
import 'package:health_ai/Screens/doctor/dashboard.dart';
import 'package:health_ai/Screens/login_screen.dart';
import 'package:health_ai/Screens/doctor/mainPage.dart';
import 'package:health_ai/Screens/on_boardingpage.dart';
import 'package:health_ai/Screens/profile_screen.dart';

import 'package:health_ai/Screens/sign_up.dart';
import 'package:health_ai/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Health Ai',
        initialRoute: MyRoutes.mainPage,
        routes: {
          MyRoutes.onBoarding: (context) => OnBoarding(),
          MyRoutes.loginPage: (context) => LoginScreen(),
          MyRoutes.dashboard: (context) => Dashboard(),
          MyRoutes.doctorOrPatient: (context) => DoctorOrPatient(),
          MyRoutes.mainPage: (context) => MainPage(),
          MyRoutes.signUp: (context) => SignUp(),
          MyRoutes.profile: (context) => ProfilePage(),
        });
  }
}
