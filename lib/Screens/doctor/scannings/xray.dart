import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class XrayDoc extends StatefulWidget {
  const XrayDoc({super.key});

  @override
  State<XrayDoc> createState() => _XrayDocState();
}

class _XrayDocState extends State<XrayDoc> {
  String dropdownValueScan = 'Xray';
  String dropdownValueOrgan = 'Chest';
  String selectedImagePath = "";
  final picker = ImagePicker();
  File? img;
  Future pickImage() async {
    XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
    if (xfile == null) return;
    PickedFile? pickedFile = PickedFile(xfile.path);
    setState(() {
      selectedImagePath = pickedFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text("Xray Scan"),
          SizedBox(height: 20),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: Colors.black),
            ),
            child: selectedImagePath.isEmpty
                ? Icon(
                    Icons.photo_camera_back_outlined,
                    size: 100,
                    color: Colors.indigo[900],
                  )
                : Image(
                    image: FileImage(
                      File(selectedImagePath),
                    ),
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: const Text("Upload Image"),
            ),
          ),
        ],
      ),
    ));
    ;
  }
}
