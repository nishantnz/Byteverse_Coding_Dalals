// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_ai/utils/routes.dart';
import 'package:image_picker/image_picker.dart';

class GetPatientData extends StatelessWidget {
  final ageEditingController = TextEditingController();
  final addressEditingController = TextEditingController();

  void handleImage(bool clickImage) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    if (!clickImage) {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    } else {
      // Capture a photo.
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.black),
          // ),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(14),
                child: Text(
                  "User Additional Details",
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff432C81),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: ageEditingController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Age',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  maxLines: 3,
                  controller: addressEditingController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Address',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: TextButton(
                  onPressed: () => handleImage(true),
                  child: Text('Click Image'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: TextButton(
                  onPressed: () => handleImage(false),
                  child: Text('Upload Image'),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff432C81),
                  ),
                  onPressed: () {
                    // SignIn();
                    Navigator.pushNamed(context, MyRoutes.patientMainPage);
                  },
                  child: Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
