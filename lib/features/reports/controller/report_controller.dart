import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:healthai/features/reports/repository/report_repository.dart';
import 'package:healthai/models/report_model.dart';

final reportControllerProvider = Provider((ref) {
  final reportRepository = ref.read(reportRepositoryProvider);
  return ReportController(reportRepository: reportRepository, ref: ref);
});

class ReportController {
  final ReportRepository reportRepository;
  final ProviderRef ref;
  ReportController({
    required this.reportRepository,
    required this.ref,
  });

  Stream<List<ReportModel>> getPatientAllReportsController(
    BuildContext context,
  ) {
    return reportRepository.getAllPatientReportsByPatient(context);
  }

  Stream<List<ReportModel>> getDoctorAllReportsController(
    BuildContext context,
  ) {
    return reportRepository.getAllReportsByDoctor(context);
  }

  Stream<List<ReportModel>> getPatientAllReportsByDoctorController(
      BuildContext context, String patientUserId) {
    return reportRepository.getAllPatientReportsByDoctor(
      context,
      patientUserId,
    );
  }

  Future<ReportModel?> getPatientLatestReportsController(
    BuildContext context,
  ) {
    return reportRepository.getLatestPatientReportByPatient(context);
  }

  void sendReportToDoctorController({
    required BuildContext context,
    required String doctorUserId,
    required ReportModel report,
  }) {
    return reportRepository.sendReportToDoctor(
      context: context,
      doctorUserId: doctorUserId,
      report: report,
    );
  }
}
