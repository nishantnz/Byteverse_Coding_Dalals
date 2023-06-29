import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/enums/user_type_enum.dart';

import 'package:healthai/features/scans/repository/scan_repository.dart';

final scanControllerProvider = Provider((ref) {
  final scanRepository = ref.read(scanRepositoryProvider);
  return ScanController(scanRepository: scanRepository, ref: ref);
});

class ScanController {
  final ScanRepository scanRepository;
  final ProviderRef ref;
  ScanController({
    required this.scanRepository,
    required this.ref,
  });

  void saveReportController({
    required BuildContext context,
    required String output,
    required File image,
    required UserTypeEnum userTypeEnum,
    String? patientName,
    required String type,
  }) async {
    return scanRepository.saveReportToFirebase(
      context: context,
      ref: ref,
      output: output,
      image: image,
      userTypeEnum: userTypeEnum,
      type: type,
      patientName: patientName,
    );
  }
}
