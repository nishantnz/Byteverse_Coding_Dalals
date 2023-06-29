import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/common/enums/user_type_enum.dart';

import 'package:healthai/features/auth/repository/auth_repository.dart';
import 'package:healthai/models/doctor_model.dart';
import 'package:healthai/models/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(ref: ref, authRepository: authRepository);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getuserData();
});

class AuthController {
  final ProviderRef ref;
  final AuthRepository authRepository;

  AuthController({
    required this.ref,
    required this.authRepository,
  });

  Future<String?> getuserData() async {
    String? userId = await authRepository.getCurrentUserData();
    return userId;
  }

  void logout() {
    return authRepository.logoutUser();
  }

  void signUpWithPhone({
    required BuildContext context,
    required String email,
    required String password,
    required UserTypeEnum type,
  }) {
    return authRepository.createUserWithEmailAndPassword(
      context: context,
      email: email,
      password: password,
      type: type,
    );
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required String name,
    required String phoneNumber,
    required File? profilePic,
    String? expertise,
    String? address,
    required UserTypeEnum type,
  }) {
    return authRepository.saveUserDataToFirebase(
      context: context,
      name: name,
      phoneNumber: phoneNumber,
      expertise: expertise,
      address: address,
      profilePic: profilePic,
      type: type,
      ref: ref,
    );
  }

  void signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
    required UserTypeEnum type,
  }) {
    return authRepository.signInWithEmailAndPassword(
      context: context,
      email: email,
      password: password,
      type: type,
    );
  }

  Stream<List<UserModel>> getListOfPatientsController() {
    return authRepository.getListofPatients();
  }

  Stream<List<DoctorModel>> getListOfDoctorsController() {
    return authRepository.getListofDoctors();
  }

  void savePatientToDoctorList({
    required BuildContext context,
    required String doctorId,
  }) {
    return authRepository.savePatientInDoctorList(context, doctorId);
  }
}
