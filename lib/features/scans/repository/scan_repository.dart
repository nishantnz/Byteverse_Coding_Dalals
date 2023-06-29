import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/enums/user_type_enum.dart';
import 'package:healthai/common/repositories/common_firebase_storage_repositories.dart';
import 'package:healthai/common/widgets/common_snackbar.dart';
import 'package:healthai/features/profile/controller/profile_details_controller.dart';
import 'package:healthai/models/report_model.dart';
import 'package:uuid/uuid.dart';

final scanRepositoryProvider = Provider(
  (ref) => ScanRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class ScanRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ScanRepository({
    required this.firestore,
    required this.auth,
  });

  void saveReportToFirebase({
    required BuildContext context,
    required ProviderRef ref,
    required String output,
    required File image,
    required UserTypeEnum userTypeEnum,
    required String type,
    String? patientName,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = '';

      var uniqueReportId = const Uuid().v1();
      var name =
          await ref.read(profileDetailsControllerProvider).getUsername(context);

      photoUrl = await ref
          .read(commonFirebaseStorageRepositoriesProvider)
          .storeFileToFirebase(
            'reports/$uid/$type/$uniqueReportId',
            image,
          );
      var report = ReportModel(
        name: name!,
        type: type,
        output: output,
        picture: photoUrl,
        patientName: patientName,
        reportId: uniqueReportId,
        timeUploaded: DateTime.now(),
      );

      await firestore
          .collection('users')
          .doc(uid)
          .collection('reports')
          .doc(uniqueReportId)
          .set(report.toMap());

      await firestore
          .collection('users')
          .doc(uid)
          .collection('latest report')
          .doc(uid)
          .set(report.toMap());
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
  }
}
