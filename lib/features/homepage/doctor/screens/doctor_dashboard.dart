import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/homepage/doctor/screens/doctor_all_scan_pages.dart';
import 'package:healthai/features/list%20of%20users/screens/list_of_patients.dart';
import 'package:healthai/features/profile/controller/profile_details_controller.dart';
import 'package:healthai/features/profile/widgets/list_tile_widget.dart';
import 'package:healthai/features/reports/screens/doctor/doctor_all_reports.dart';
import 'package:healthai/features/reports/screens/doctor/list_of_patients_for_reports_screen.dart';

class DoctorDashboard extends ConsumerWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future:
              ref.read(profileDetailsControllerProvider).getUsername(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoaderWidget();
            }
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Welcome Dr. ${snapshot.data}",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                Column(
                  children: [
                    ListTileWidget(
                      icon: Icons.search,
                      text: 'Scan an image to get result',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DoctorAllScanPages.routeName,
                        );
                      },
                    ),
                    ListTileWidget(
                      icon: Icons.mail,
                      text: 'See your reports',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DoctorAllReports.routeName,
                        );
                      },
                    ),
                    ListTileWidget(
                        icon: Icons.mail,
                        text: 'See patient reports',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ListofPatientsForReports.routeName,
                          );
                        }),
                    ListTileWidget(
                      icon: Icons.phone,
                      text: 'Messages',
                      onTap: () {
                        Navigator.pushNamed(context, ListofPatients.routeName);
                      },
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
