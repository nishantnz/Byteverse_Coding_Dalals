import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanningReport extends StatefulWidget {
  // const ScanningReport({super.key});

  @override
  State<ScanningReport> createState() => _ScanningReportState();
}

class _ScanningReportState extends State<ScanningReport> {
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.start,

            children: [
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Choose The type of Scan you would like to get results for:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton(
                  dropdownColor: Colors.indigo[50],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_drop_down_circle_outlined),
                  ),
                  value: dropdownValueScan,
                  items: const [
                    DropdownMenuItem(
                      value: "Xray",
                      child: Text("Xray"),
                    ),
                    DropdownMenuItem(
                      value: "CT Scan",
                      child: Text("CT Scan"),
                    ),
                    DropdownMenuItem(
                      value: "MRI",
                      child: Text("MRI"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      dropdownValueScan = value!;
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    "Choose The orgran you would like to get results for:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              DropdownButton(
                  dropdownColor: Colors.indigo[50],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                  borderRadius: BorderRadius.circular(10),
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_drop_down_circle_outlined),
                  ),
                  value: dropdownValueOrgan,
                  items: const [
                    DropdownMenuItem(
                      value: "Chest",
                      child: Text("Chest"),
                    ),
                    DropdownMenuItem(
                      value: "Brain",
                      child: Text("Brain"),
                    ),
                    // DropdownMenuItem(
                    //   value: "MRI",
                    //   child: Text("MRI"),
                    // ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      dropdownValueOrgan = value!;
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
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
        ),
      ),
    );
  }
}
