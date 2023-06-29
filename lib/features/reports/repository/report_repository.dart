import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/widgets/common_snackbar.dart';
import 'package:healthai/models/report_model.dart';

final reportRepositoryProvider = Provider(
  (ref) => ReportRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class ReportRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ReportRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<ReportModel>> getAllPatientReportsByPatient(
    BuildContext context,
  ) {
    String uid = auth.currentUser!.uid;
    debugPrint(uid);
    List<ReportModel> reports = [];
    return firestore
        .collection('users')
        .doc(uid)
        .collection('reports')
        .orderBy('timeUploaded', descending: true)
        .snapshots()
        .map((event) {
      for (var element in event.docs) {
        reports.add(ReportModel.fromMap(element.data()));
      }
      return reports;
    });
  }

  void sendReportToDoctor({
    required BuildContext context,
    required String doctorUserId,
    required ReportModel report,
  }) async {
    try {
      String patientUserId = auth.currentUser!.uid;
      await firestore
          .collection('users')
          .doc(doctorUserId)
          .collection('patient report history')
          .doc(patientUserId)
          .collection('reports')
          .doc(report.reportId)
          .set(report.toMap());
      await firestore
          .collection('users')
          .doc(doctorUserId)
          .collection('patient report history')
          .doc(patientUserId)
          .collection('latest reports')
          .doc(patientUserId)
          .set(report.toMap());

      Future.delayed(const Duration(seconds: 1)).then((value) {
        showsnackbar(
          context: context,
          msg: 'report sent to doctor successfully',
        );
      });
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
  }

  Stream<List<ReportModel>> getAllReportsByDoctor(
    BuildContext context,
  ) {
    String uid = auth.currentUser!.uid;
    List<ReportModel> reports = [];
    return firestore
        .collection('users')
        .doc(uid)
        .collection('reports')
        .snapshots()
        .map((event) {
      for (var element in event.docs) {
        reports.add(ReportModel.fromMap(element.data()));
      }
      return reports;
    });
  }

  Stream<List<ReportModel>> getAllPatientReportsByDoctor(
      BuildContext context, String patientUserId) {
    String uid = auth.currentUser!.uid;
    List<ReportModel> reports = [];
    return firestore
        .collection('users')
        .doc(uid)
        .collection('patient report history')
        .doc(patientUserId)
        .collection('reports')
        .snapshots()
        .map((event) {
      for (var element in event.docs) {
        debugPrint("hello");
        debugPrint("${element.data()}");
        reports.add(ReportModel.fromMap(element.data()));
      }
      return reports;
    });
  }

  Future<ReportModel?> getLatestPatientReportByPatient(
    BuildContext context,
  ) async {
    try {
      String uid = auth.currentUser!.uid;
      ReportModel reports;
      var reportData = await firestore
          .collection('users')
          .doc(uid)
          .collection('latest report')
          .doc(uid)
          .get();
      reports = ReportModel.fromMap(reportData.data()!);
      return reports;
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
      return null;
    }
  }
}
