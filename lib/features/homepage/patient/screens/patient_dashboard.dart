import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/homepage/patient/screens/patient_all_scan_pages.dart';
import 'package:healthai/features/list%20of%20users/screens/list_of_doctors.dart';
import 'package:healthai/features/profile/controller/profile_details_controller.dart';
import 'package:healthai/features/profile/widgets/list_tile_widget.dart';
import 'package:healthai/features/reports/controller/report_controller.dart';
import 'package:healthai/features/reports/screens/patient/detailed_report.dart';

class PatientDashboard extends ConsumerWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder(
          future: ref
              .read(profileDetailsControllerProvider)
              .getPatientDetails(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoaderWidget();
            }
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "👋 Welcome back ${snapshot.data!.name}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      decoration: const BoxDecoration(
                        //color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset("assets/images/doc_logo.png"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "What would you like to do today?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    ListTileWidget(
                      icon: Icons.search,
                      text: 'Scan for disease',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PatientAllScanPages.routeName,
                        );
                      },
                    ),
                    ListTileWidget(
                      icon: Icons.mail,
                      text: 'See latest report',
                      onTap: () async {
                        var report = await ref
                            .read(reportControllerProvider)
                            .getPatientLatestReportsController(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientDetailedReport(
                              patientImage: snapshot.data!.profilePic,
                              patientName: snapshot.data!.name,
                              type: report!.type,
                              reportImage: report.picture,
                              output: report.output,
                            ),
                          ),
                        );
                      },
                    ),
                    ListTileWidget(
                      icon: Icons.phone,
                      text: 'Contact Doctor',
                      onTap: () {
                        Navigator.pushNamed(context, ListOfDoctors.routeName);
                      },
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
