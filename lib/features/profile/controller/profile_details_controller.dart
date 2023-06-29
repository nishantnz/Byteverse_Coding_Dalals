import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:healthai/features/profile/repository/profile_details_repository.dart';
import 'package:healthai/models/doctor_model.dart';
import 'package:healthai/models/user_model.dart';

final profileDetailsControllerProvider = Provider((ref) {
  final profileDetailsRepository = ref.watch(profileDetailsRepositoryProvider);
  return ProfileDetailsController(
      profileDetailsRepository: profileDetailsRepository, ref: ref);
});

class ProfileDetailsController {
  final ProfileDetailsRepository profileDetailsRepository;
  final ProviderRef ref;
  ProfileDetailsController({
    required this.profileDetailsRepository,
    required this.ref,
  });

  Future<UserModel?> getPatientDetails(BuildContext context) {
    return profileDetailsRepository.getPatientDetails(context);
  }

  Future<DoctorModel?> getDoctorDetails(BuildContext context) {
    return profileDetailsRepository.getDocDetails(context);
  }

  void updatePatientName(BuildContext context, String newName) {
    return profileDetailsRepository.changePatientName(context, newName);
  }

  void updatePatientProfilePic(BuildContext context, File newPic) {
    return profileDetailsRepository.changePatientProfilePic(context, newPic);
  }

  void updateDoctorName(BuildContext context, String newName) {
    return profileDetailsRepository.changeDoctorName(context, newName);
  }

  void updateDoctorProfilePic(BuildContext context, File newPic) {
    return profileDetailsRepository.changeDoctorProfilePic(context, newPic);
  }

  Future<String?> getUsername(BuildContext context) {
    return profileDetailsRepository.getName(context);
  }
}
