import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/widgets/error.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/profile/controller/profile_details_controller.dart';
import 'package:healthai/features/reports/controller/report_controller.dart';
import 'package:healthai/features/reports/screens/doctor/doctor_detailed_report.dart';
import 'package:healthai/models/report_model.dart';

class DoctorAllReports extends ConsumerWidget {
  const DoctorAllReports({
    Key? key,
  }) : super(key: key);

  static const routeName = '/doctor-all-reports';

  void onTap({
    required BuildContext context,
    required ReportModel report,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorDetailedReport(
            patientName: report.patientName!,
            type: report.type,
            reportImage: report.picture,
            output: report.output),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(profileDetailsControllerProvider).getUsername(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoaderPage();
        }
        var userName = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text('${userName!} Reports'),
          ),
          body: StreamBuilder<List<ReportModel?>?>(
            stream: ref
                .read(reportControllerProvider)
                .getDoctorAllReportsController(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoaderWidget();
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
                          onTap: () => onTap(context: context, report: report),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(report!.picture),
                              radius: 30,
                            ),
                            title: Text(report.type),
                            subtitle: Text(report.output),
                            trailing: IconButton(
                              onPressed: () =>
                                  onTap(context: context, report: report),
                              icon:
                                  const Icon(Icons.keyboard_arrow_right_sharp),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        );
      },
    );
  }
}
