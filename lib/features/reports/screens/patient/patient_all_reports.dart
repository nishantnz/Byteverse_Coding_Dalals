import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:healthai/common/widgets/error.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/reports/controller/report_controller.dart';
import 'package:healthai/features/reports/screens/patient/detailed_report.dart';
import 'package:healthai/models/report_model.dart';

class PatientAllReports extends ConsumerWidget {
  const PatientAllReports({
    Key? key,
    required this.patientName,
    required this.patientImage,
  }) : super(key: key);
  final String patientName;
  final String patientImage;

  void onTap({
    required BuildContext context,
    required ReportModel report,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientDetailedReport(
          patientImage: patientImage,
          patientName: patientName,
          type: report.type,
          reportImage: report.picture,
          output: report.output,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<ReportModel?>?>(
      stream: ref
          .read(reportControllerProvider)
          .getPatientAllReportsController(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoaderPage();
        }
        return snapshot.data == null
            ? const ErrorScreen(
                error:
                    'Error while retireving reports list. please try again later',
              )
            : ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final report = snapshot.data![index];
                  return InkWell(
                    onTap: () => onTap(
                      context: context,
                      report: report,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(report!.picture),
                        radius: 30,
                      ),
                      title: Text(report.type),
                      subtitle: Text(report.output),
                      trailing: IconButton(
                        onPressed: () => onTap(
                          context: context,
                          report: report,
                        ),
                        icon: const Icon(Icons.keyboard_arrow_right_sharp),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
