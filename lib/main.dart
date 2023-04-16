import 'package:flutter/material.dart';
import 'package:health_ai/Screens/Patients/dashboard.dart';
import 'package:health_ai/Screens/Patients/detailed_report_screen.dart';
import 'package:health_ai/Screens/Patients/login_screen.dart';
import 'package:health_ai/Screens/Patients/mainPage.dart';
import 'package:health_ai/Screens/Patients/new_disease.dart';
import 'package:health_ai/Screens/Patients/patient_data.dart';
import 'package:health_ai/Screens/Patients/patients_history.dart';
import 'package:health_ai/Screens/Patients/scanning_report.dart';
import 'package:health_ai/Screens/Patients/sign_up.dart';
import 'package:health_ai/Screens/doctor/login_screen.dart';
import 'package:health_ai/Screens/doctor/patientLabAnalysis.dart';
import 'package:health_ai/Screens/doctor/report_image_doctor.dart';
import 'package:health_ai/Screens/doctor/scannings/ct.dart';
import 'package:health_ai/Screens/doctor/scannings/mri.dart';
import 'package:health_ai/Screens/doctor/scannings/xray.dart';
import 'package:health_ai/Screens/doctor/schedulingPatients.dart';
import 'package:health_ai/Screens/doctor/sign_up.dart';
import 'package:health_ai/Screens/doctorOrPatient.dart';
import 'package:health_ai/Screens/doctor/dashboard.dart';
import 'package:health_ai/Screens/doctor/mainPage.dart';
import 'package:health_ai/Screens/on_boardingpage.dart';
import 'package:health_ai/Screens/profile_screen.dart';
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
        initialRoute: MyRoutes.docloginPage,
        routes: {
          MyRoutes.onBoarding: (context) => OnBoarding(),
          MyRoutes.docloginPage: (context) => DoctorLoginScreen(),
          MyRoutes.dashboard: (context) => Dashboard(),
          MyRoutes.doctorOrPatient: (context) => DoctorOrPatient(),
          MyRoutes.mainPage: (context) => MainPage(),
          MyRoutes.patientMainPage: (context) => PatientMainPage(),
          MyRoutes.docSignUp: (context) => DoctorSignUp(),
          MyRoutes.profile: (context) => ProfilePage(),
          MyRoutes.patientDashboard: (context) => PatientDashboard(),
          MyRoutes.patientHistory: (context) => PatientsHistory(),
          MyRoutes.patientLogin: (context) => PatientLoginScreen(),
          MyRoutes.patientSignUp: (context) => PatientSignUp(),
          MyRoutes.scanningReportPateint: (context) => ScanningReport(),
          MyRoutes.scheduling_patients: (context) => SchedulingPatients(),
          MyRoutes.reportImageDoctor: (context) => ReportImageDoctor(),
          MyRoutes.ctdoc: (context) => CTDoc(),
          MyRoutes.mridoc: (context) => MRIDoc(),
          MyRoutes.xraydoc: (context) => XrayDoc(),
          MyRoutes.doctorPatientLabAnalysis: (context) =>
              DoctorPatientLabAnalysis(),
          MyRoutes.patientDetailedReportScreen: (context) =>
              DetailedReportScreen(),
        });
  }
}
