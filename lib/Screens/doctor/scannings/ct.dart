import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CTDoc extends StatefulWidget {
  CTDoc({super.key});

  @override
  State<CTDoc> createState() => _CTDocState();
}

class _CTDocState extends State<CTDoc> {
  String selectedImagePath = "";
  var resJson;
  var resultOfPrediction;
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

  Future uploadImage(File imageFile) async {
    var headers = {
      'Cookie':
          'Authorization="Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwNVVJWFc2VkpCIiwiZXhwIjoxNjgxNzE0NDc2fQ.zNTRtSH-ZkV5BZr-dfkVYivHcg2T3bu69NQ96H-3JyE"'
    };

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://healthai.koreacentral.cloudapp.azure.com/predict/upload'));
    request.fields.addAll({'scan_type': 'MR'});
    request.files
        .add(await http.MultipartFile.fromPath('files', imageFile.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      // print(response);
      // print("success");
      var res = await response.stream.bytesToString();
      setState(() {
        resJson = jsonDecode(res);

        resultOfPrediction = resJson;
      });

      //print(resultOfPrediction);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text("CT Scan"),
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
              onPressed: () async {
                await pickImage();
                if (selectedImagePath.isNotEmpty) {
                  await uploadImage(File(selectedImagePath));
                }
              },
              child: Text(selectedImagePath.isNotEmpty
                  ? resultOfPrediction == null
                      ? "Uploading Image"
                      : "Select new Image"
                  : "Select Image"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: selectedImagePath.isEmpty
                ? Text("Please upload an image first")
                : resultOfPrediction == null
                    ? const Text(
                        "Loading...",
                      )
                    : Text(
                        "The patient has ${resultOfPrediction[0]}",
                      ),
          ),
        ],
      ),
    ));
    ;
  }
}
