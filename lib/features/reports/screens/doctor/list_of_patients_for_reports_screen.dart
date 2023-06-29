import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/widgets/error.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/auth/controller/auth_controller.dart';
import 'package:healthai/features/reports/screens/doctor/patient_all_reports_by_doctor.dart';
import 'package:healthai/models/user_model.dart';
import 'package:lottie/lottie.dart';

class ListofPatientsForReports extends ConsumerWidget {
  const ListofPatientsForReports({
    Key? key,
  }) : super(key: key);

  static const routeName = '/list-of-patients-for-reports';

  void onTap({required BuildContext context, required UserModel users}) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllPatientReportsByDoctor(
          patientName: users.name,
          patientId: users.actualId,
          patientImage: users.profilePic,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Patient List'),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: ref.read(authControllerProvider).getListOfPatientsController(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoaderPage();
          }
          return snapshot.data == null
              ? const ErrorScreen(
                  error:
                      'Error while retireving patient list. please try again later',
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final users = snapshot.data![index];
                      return InkWell(
                        onTap: () => onTap(context: context, users: users),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              users.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: SizedBox(
                              width: 50,
                              height: 50,
                              child: Lottie.asset(
                                "assets/files/lab_result.json",
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
