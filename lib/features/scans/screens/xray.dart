import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:healthai/colors.dart';
import 'package:healthai/common/enums/user_type_enum.dart';
import 'package:healthai/common/widgets/common_snackbar.dart';
import 'package:healthai/common/widgets/image_picker.dart';
import 'package:healthai/common/widgets/loader.dart';
import 'package:healthai/features/scans/controller/scan_controller.dart';

class XRayScan extends ConsumerStatefulWidget {
  const XRayScan({
    super.key,
    required this.type,
  });
  final UserTypeEnum type;
  static const routeName = '/xray-scan';

  @override
  ConsumerState<XRayScan> createState() => _XRayScan();
}

class _XRayScan extends ConsumerState<XRayScan> {
  File? image;
  String? output;
  String? result;
  String? patientName;
  final TextEditingController nameController = TextEditingController();
  bool gettingResult = false;
  void selectImage(BuildContext context) async {
    image = await addPhoto(context);
    setState(() {});
  }

  void getResult() async {
    setState(() {
      gettingResult = true;
      output = null;
    });
    var url = Uri.parse(
      'https://getprediction-5eh7jedtsq-el.a.run.app/xray',
    );
    // open a bytestream
    var stream = http.ByteStream(DelegatingStream.typed(image!.openRead()));
    // get file length
    var length = await image!.length();
    // create multipart request
    var request = http.MultipartRequest("POST", url);
    // multipart that takes file
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(image!.path));
    // add file to multipart
    request.files.add(multipartFile);
    // send
    var response = await request.send();
    debugPrint('${response.statusCode}');
    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      debugPrint(value);
      if (response.statusCode == 200 && !value.contains('Not Detected')) {
        setState(() {
          result = value;
          output = value;
          gettingResult = false;
        });
      } else {
        setState(() {
          result = value;
          gettingResult = false;
        });
      }
    });
  }

  void saveReport(BuildContext context) {
    try {
      if (nameController.text.trim().isNotEmpty) {
        patientName = nameController.text.trim();
      }
      ref.read(scanControllerProvider).saveReportController(
            context: context,
            output: output!,
            image: image!,
            userTypeEnum: widget.type,
            type: 'xray',
            patientName: patientName,
          );
      Future.delayed(const Duration(seconds: 1)).then(
        (value) => showsnackbar(
          context: context,
          msg: 'Report added successfully',
        ),
      );
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'XRay Scan by ${widget.type == UserTypeEnum.doctor ? 'Doctor' : 'Patient'}',
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      image == null
                          ? const CircleAvatar(
                              radius: 100,
                              backgroundColor: blackColor,
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(image!),
                              radius: 100,
                            ),
                      Positioned(
                        bottom: -10,
                        right: -5,
                        child: IconButton(
                          onPressed: () => selectImage(context),
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (widget.type == UserTypeEnum.doctor)
                    Container(
                      width: size.width * 0.85,
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter patient name',
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(10),
                    child: gettingResult
                        ? const LoaderWidget()
                        : Text(
                            result == null ? 'results here' : result!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                          ),
                  ),
                  const SizedBox(height: 20),
                  if (image != null)
                    ElevatedButton(
                      onPressed: () => getResult(),
                      child: const Text(
                        'Get results',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (output != null)
                    ElevatedButton(
                      onPressed: () => saveReport(context),
                      child: const Text(
                        'Save to reports',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
