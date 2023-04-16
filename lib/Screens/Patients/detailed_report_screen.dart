// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:health_ai/utils/routes.dart';

class DetailedReportScreen extends StatefulWidget {
  const DetailedReportScreen({super.key});

  @override
  State<DetailedReportScreen> createState() => _DoctorPatientLabAnalysisState();
}

class _DoctorPatientLabAnalysisState extends State<DetailedReportScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    String id = data['id']!;
    String disease = data['disease']!;
    String image = data['img']!;
    String pid = data['patientId']!;
    String stype = data['scan_type']!;
    String path =
        'http://9886-2409-4040-d94-94bc-c27-13c3-7df8-dcac.ngrok-free.app/storage/$pid/processed/$image';
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Detailed Report $id",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Patient Id: $pid",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text("Diagnosis of the Patient:"),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text("Type of Scan : $stype"),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, MyRoutes.reportImageDoctor),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Image.network(
                      path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Report : $disease",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
