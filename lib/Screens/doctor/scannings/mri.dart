import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class MRIDoc extends StatefulWidget {
  const MRIDoc({super.key});

  @override
  State<MRIDoc> createState() => _MRIDocState();
}

class _MRIDocState extends State<MRIDoc> {
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
          Text("MRI Scan"),
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "results",
            ),
          ),
        ],
      ),
    ));
  }
}
