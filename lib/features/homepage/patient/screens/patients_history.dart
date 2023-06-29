import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/homepage/patient/screens/patient_all_scan_pages.dart';
import 'package:healthai/features/profile/controller/profile_details_controller.dart';
import 'package:healthai/features/reports/screens/patient/patient_all_reports.dart';

class PatientsHistoryPage extends ConsumerWidget {
  const PatientsHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref
            .read(profileDetailsControllerProvider)
            .getPatientDetails(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoaderPage();
          }
          var patientDetails = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('All ${patientDetails.name} reports'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: PatientAllReports(
                patientImage: patientDetails.profilePic,
                patientName: patientDetails.name,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepPurpleAccent[100],
              onPressed: () {
                Navigator.pushNamed(context, PatientAllScanPages.routeName);
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
