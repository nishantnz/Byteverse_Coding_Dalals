import 'package:flutter/material.dart';

import 'package:healthai/features/homepage/doctor/screens/report_image_doctor.dart';

class DoctorDetailedReport extends StatelessWidget {
  const DoctorDetailedReport({
    Key? key,
    required this.patientName,
    required this.type,
    required this.reportImage,
    required this.output,
  }) : super(key: key);

  final String patientName;
  final String type;
  final String reportImage;
  final String output;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "$patientName - $type report",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Patient Name: $patientName",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Diagnosis of the Patient:"),
                const SizedBox(
                  height: 10,
                ),
                Text("Type of Scan : $type"),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    ReportImageDoctor.routeName,
                  ),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.network(
                      reportImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Type of Disease : $output",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
