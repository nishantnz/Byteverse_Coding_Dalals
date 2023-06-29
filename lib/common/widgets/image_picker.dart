import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthai/common/widgets/common_snackbar.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> addPhoto(BuildContext context) async {
  File? image;

  try {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
    return image;
  } catch (e) {
    showsnackbar(context: context, msg: e.toString());
  }
  return null;
}