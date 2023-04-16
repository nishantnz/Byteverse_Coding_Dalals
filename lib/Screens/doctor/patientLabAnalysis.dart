import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_ai/utils/routes.dart';

class DoctorPatientLabAnalysis extends StatefulWidget {
  const DoctorPatientLabAnalysis({super.key});

  @override
  State<DoctorPatientLabAnalysis> createState() =>
      _DoctorPatientLabAnalysisState();
}

class _DoctorPatientLabAnalysisState extends State<DoctorPatientLabAnalysis> {
  @override
  Widget build(BuildContext context) {
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
                    "Patient Lab Analysis/Scans/Report",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  child: Image.asset("assets/images/patient1.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Patient Name: Pavan Gole",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Patient Age: 20",
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
                  child: Text("Type of Scan : Xray"),
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
                    child: Image.asset(
                      "assets/images/xray.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Type of Disease : Pneumonia",
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
