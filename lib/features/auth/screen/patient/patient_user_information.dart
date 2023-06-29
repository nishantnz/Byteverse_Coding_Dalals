import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthai/colors.dart';
import 'package:healthai/common/enums/user_type_enum.dart';
import 'package:healthai/common/widgets/common_snackbar.dart';
import 'package:healthai/common/widgets/image_picker.dart';
import 'package:healthai/features/auth/controller/auth_controller.dart';

class PatientUserInformationScreen extends ConsumerStatefulWidget {
  const PatientUserInformationScreen({super.key});

  static const routeName = '/patient-user-information';

  @override
  ConsumerState<PatientUserInformationScreen> createState() =>
      _PatientUserInformationScreenState();
}

class _PatientUserInformationScreenState
    extends ConsumerState<PatientUserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? image;

  void selectImage() async {
    image = await addPhoto(context);
    setState(() {});
  }

  void saveUserDataToFirebase() {
    String name = nameController.text.trim();
    String phoneNumber = phoneController.text.trim();

    if (name.isNotEmpty && phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
            context: context,
            name: name,
            phoneNumber: phoneNumber,
            type: UserTypeEnum.patient,
            profilePic: image,
          );
    } else {
      showsnackbar(context: context, msg: 'enter both fields');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your phone number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                IconButton(
                  onPressed: () => saveUserDataToFirebase(),
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
