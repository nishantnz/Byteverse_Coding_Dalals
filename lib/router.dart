// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:healthai/common/enums/user_type_enum.dart';
import 'package:healthai/common/widgets/error.dart';
import 'package:healthai/features/auth/screen/common/doctor_or_patient.dart';
import 'package:healthai/features/auth/screen/doctor/doctor_user_information.dart';
import 'package:healthai/features/auth/screen/patient/patient_auth_screen.dart';
import 'package:healthai/features/auth/screen/patient/patient_user_information.dart';
import 'package:healthai/features/homepage/doctor/screens/doctor_all_scan_pages.dart';
import 'package:healthai/features/homepage/doctor/screens/doctor_home_page.dart';
import 'package:healthai/features/homepage/doctor/screens/patient_lab_analysis.dart';
import 'package:healthai/features/homepage/doctor/screens/report_image_doctor.dart';
import 'package:healthai/features/homepage/patient/screens/patient_all_scan_pages.dart';
import 'package:healthai/features/homepage/patient/screens/patient_home_page.dart';
import 'package:healthai/features/list%20of%20users/screens/list_of_doctors.dart';
import 'package:healthai/features/list%20of%20users/screens/list_of_patients.dart';
import 'package:healthai/features/profile/screens/doctor/doctor_profile_screen.dart';
import 'package:healthai/features/profile/screens/patient/patient_profile_screen.dart';
import 'package:healthai/features/reports/screens/doctor/doctor_all_reports.dart';
import 'package:healthai/features/reports/screens/doctor/list_of_patients_for_reports_screen.dart';
import 'package:healthai/features/scans/screens/ct.dart';
import 'package:healthai/features/scans/screens/mri.dart';
import 'package:healthai/features/scans/screens/skin_disease.dart';
import 'package:healthai/features/scans/screens/xray.dart';
import 'features/auth/screen/doctor/doctor_auth_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    // AUTH
    case DoctorAuth.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorAuth(),
      );
    case DoctorOrPatient.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorOrPatient(),
      );
    case PatientAuth.routeName:
      return MaterialPageRoute(
        builder: (context) => const PatientAuth(),
      );
    case PatientUserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const PatientUserInformationScreen(),
      );
    case DoctorUserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorUserInformationScreen(),
      );

    // PROFILE PAGE AND SETTINGS SCREEN
    case DoctorProfilePage.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorProfilePage(),
      );
    case PatientProfilePage.routeName:
      return MaterialPageRoute(
        builder: (context) => const PatientProfilePage(),
      );

    case PatientHomePage.routeName:
      return MaterialPageRoute(
        builder: (context) => const PatientHomePage(),
      );

    case DoctorHomePage.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorHomePage(),
      );

    // scans pages
    case XRayScan.routeName:
      final userTypeEnum = settings.arguments as UserTypeEnum;
      return MaterialPageRoute(
        builder: (context) => XRayScan(
          type: userTypeEnum,
        ),
      );
    case MRIScan.routeName:
      final userTypeEnum = settings.arguments as UserTypeEnum;
      return MaterialPageRoute(
        builder: (context) => MRIScan(
          type: userTypeEnum,
        ),
      );
    case CTScan.routeName:
      final userTypeEnum = settings.arguments as UserTypeEnum;
      return MaterialPageRoute(
        builder: (context) => CTScan(
          type: userTypeEnum,
        ),
      );
    case SkinDiseaseScan.routeName:
      final userTypeEnum = settings.arguments as UserTypeEnum;
      return MaterialPageRoute(
        builder: (context) => SkinDiseaseScan(
          type: userTypeEnum,
        ),
      );

    case DoctorPatientLabAnalysis.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorPatientLabAnalysis(),
      );
    case ReportImageDoctor.routeName:
      return MaterialPageRoute(
        builder: (context) => const ReportImageDoctor(),
      );

    case DoctorAllScanPages.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorAllScanPages(),
      );

    case PatientAllScanPages.routeName:
      return MaterialPageRoute(
        builder: (context) => const PatientAllScanPages(),
      );
    case ListOfDoctors.routeName:
      return MaterialPageRoute(
        builder: (context) => const ListOfDoctors(),
      );
    case ListofPatients.routeName:
      return MaterialPageRoute(
        builder: (context) => const ListofPatients(),
      );

    case DoctorAllReports.routeName:
      return MaterialPageRoute(
        builder: (context) => const DoctorAllReports(),
      );
    case ListofPatientsForReports.routeName:
      return MaterialPageRoute(
        builder: (context) => const ListofPatientsForReports(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: const ErrorScreen(error: 'This page does not exist'),
        ),
      );
  }
}
