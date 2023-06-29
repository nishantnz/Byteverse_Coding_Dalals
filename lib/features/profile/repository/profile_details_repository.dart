import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/repositories/common_firebase_storage_repositories.dart';
import 'package:healthai/common/widgets/common_snackbar.dart';
import 'package:healthai/features/homepage/doctor/screens/doctor_home_page.dart';
import 'package:healthai/features/homepage/patient/screens/patient_home_page.dart';
import 'package:healthai/models/doctor_model.dart';
import 'package:healthai/models/user_model.dart';

final profileDetailsRepositoryProvider = Provider((ref) {
  return ProfileDetailsRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  );
});

class ProfileDetailsRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  ProfileDetailsRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  Future<DoctorModel?> getDocDetails(BuildContext context) async {
    try {
      DoctorModel docDetails;
      var userData =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
      docDetails = DoctorModel.fromMap(userData.data()!);
      return docDetails;
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
    return null;
  }

  Future<UserModel?> getPatientDetails(BuildContext context) async {
    try {
      UserModel patientDetails;
      var userData =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
      patientDetails = UserModel.fromMap(userData.data()!);
      return patientDetails;
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
    return null;
  }

  void changePatientName(BuildContext context, String newName) async {
    try {
      var existingUser = await getPatientDetails(context);
      var newUser = UserModel(
        name: newName,
        userId: existingUser!.userId,
        actualId: existingUser.actualId,
        phoneNumber: existingUser.phoneNumber,
        email: existingUser.email,
        profilePic: existingUser.profilePic,
      );
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(newUser.toMap());

      Future.delayed(const Duration(seconds: 2)).then((value) {
        showsnackbar(context: context, msg: 'Details updated successfully');
        Navigator.popAndPushNamed(context, PatientHomePage.routeName);
      });
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
  }

  void changePatientProfilePic(BuildContext context, File newPic) async {
    try {
      var existingUser = await getPatientDetails(context);
      String photoUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuMT6kuEjCVGQmABoZtE-s1X_Eo5EcAH277BxLriNjnQ&s';
      String uid = auth.currentUser!.uid;
      photoUrl = await ref
          .read(commonFirebaseStorageRepositoriesProvider)
          .storeFileToFirebase(
            'profilePic/$uid',
            newPic,
          );

      var newUser = UserModel(
        name: existingUser!.name,
        actualId: existingUser.actualId,
        userId: existingUser.userId,
        phoneNumber: existingUser.phoneNumber,
        email: existingUser.email,
        profilePic: photoUrl,
      );
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(newUser.toMap());

      Future.delayed(const Duration(seconds: 2)).then((value) {
        showsnackbar(context: context, msg: 'Details updated successfully');
        Navigator.popAndPushNamed(context, PatientHomePage.routeName);
      });
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
  }

  void changeDoctorName(BuildContext context, String newName) async {
    try {
      var existingUser = await getDocDetails(context);
      var newUser = DoctorModel(
          name: newName,
          userId: existingUser!.userId,
          actualId: existingUser.actualId,
          phoneNumber: existingUser.phoneNumber,
          email: existingUser.email,
          profilePic: existingUser.profilePic,
          address: existingUser.address,
          expertise: existingUser.expertise);
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(newUser.toMap());

      Future.delayed(const Duration(seconds: 2)).then((value) {
        showsnackbar(context: context, msg: 'Details updated successfully');
        Navigator.popAndPushNamed(context, DoctorHomePage.routeName);
      });
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
  }

  void changeDoctorProfilePic(BuildContext context, File newPic) async {
    try {
      var existingUser = await getDocDetails(context);
      String photoUrl = '';
      String uid = auth.currentUser!.uid;
      photoUrl = await ref
          .read(commonFirebaseStorageRepositoriesProvider)
          .storeFileToFirebase(
            'profilePic/$uid',
            newPic,
          );

      var newUser = DoctorModel(
          name: existingUser!.name,
          actualId: existingUser.actualId,
          userId: existingUser.userId,
          phoneNumber: existingUser.phoneNumber,
          email: existingUser.email,
          profilePic: photoUrl,
          address: existingUser.address,
          expertise: existingUser.expertise);
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(newUser.toMap());

      Future.delayed(const Duration(seconds: 2)).then((value) {
        showsnackbar(context: context, msg: 'Details updated successfully');
        Navigator.popAndPushNamed(context, DoctorHomePage.routeName);
      });
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
  }

  Future<String?> getName(BuildContext context) async {
    try {
      var userDetails = await getPatientDetails(context);
      return userDetails!.name;
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
    return null;
  }
}
