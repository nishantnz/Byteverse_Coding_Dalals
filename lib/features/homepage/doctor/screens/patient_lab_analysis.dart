import 'package:flutter/material.dart';
import 'package:healthai/features/homepage/doctor/screens/report_image_doctor.dart';

class DoctorPatientLabAnalysis extends StatelessWidget {
  const DoctorPatientLabAnalysis({super.key});

  static const routeName = '/doctor-patient-lab-analysis';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Patient Lab Analysis/Scans/Report",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: Image.asset("assets/images/patient1.png"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Patient Name: Pavan Gole",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Patient Age: 20",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Diagnosis of the Patient:"),
                const SizedBox(
                  height: 10,
                ),
                const Text("Type of Scan : Xray"),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
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
                    child: Image.asset(
                      "assets/images/xray.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
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
