import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:healthai/common/widgets/error.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/chat/controller/chat_controllet.dart';
import 'package:healthai/features/reports/controller/report_controller.dart';
import 'package:healthai/models/report_model.dart';

class ChooseReportToSend extends ConsumerWidget {
  const ChooseReportToSend({
    Key? key,
    required this.doctorUserId,
  }) : super(key: key);
  final String doctorUserId;

  void onTap({
    required BuildContext context,
    required WidgetRef ref,
    required ReportModel report,
  }) {
    ref.read(reportControllerProvider).sendReportToDoctorController(
          context: context,
          doctorUserId: doctorUserId,
          report: report,
        );
    ref.read(chatControllerProvider).sendTextMessageController(
          context,
          '${report.type} - scan \n link to pic: ${report.picture} \n result: ${report.output}',
          doctorUserId,
        );
    Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
    });
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
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Select report'),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final report = snapshot.data![index];
                      return GestureDetector(
                        onTap: () => onTap(
                          context: context,
                          ref: ref,
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
                              ref: ref,
                              report: report,
                            ),
                            icon: const Icon(Icons.keyboard_arrow_right_sharp),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
      },
    );
  }
}
