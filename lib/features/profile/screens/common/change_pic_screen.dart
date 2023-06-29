import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:healthai/colors.dart';
import 'package:healthai/common/enums/user_type_enum.dart';
import 'package:healthai/common/widgets/common_snackbar.dart';
import 'package:healthai/common/widgets/image_picker.dart';
import 'package:healthai/features/profile/controller/profile_details_controller.dart';

class ChangePicScreen extends ConsumerStatefulWidget {
  const ChangePicScreen({
    super.key,
    required this.type,
  });
  final UserTypeEnum type;
  static const routeName = '/update-profile-pic';

  @override
  ConsumerState<ChangePicScreen> createState() => _ChangePicScreen();
}

class _ChangePicScreen extends ConsumerState<ChangePicScreen> {
  File? image;

  void selectImage() async {
    image = await addPhoto(context);
    setState(() {});
  }

  void updateUserDataToFirebase() {
    if (image != null) {
      if (widget.type == UserTypeEnum.patient) {
        ref.read(profileDetailsControllerProvider).updatePatientProfilePic(
              context,
              image!,
            );
      } else {
        ref.read(profileDetailsControllerProvider).updateDoctorProfilePic(
              context,
              image!,
            );
      }
    } else {
      showsnackbar(context: context, msg: 'add image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    image == null
                        ? const CircleAvatar(
                            radius: 64,
                            backgroundColor: blackColor,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(image!),
                            radius: 64,
                          ),
                    Positioned(
                      bottom: -10,
                      right: -5,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: updateUserDataToFirebase,
                  icon: const Icon(Icons.done),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
