// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:health_ai/utils/routes.dart';

class DoctorOrPatient extends StatelessWidget {
  const DoctorOrPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 250,
              ),
              Container(
                height: 70,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    elevation: MaterialStateProperty.all(20),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.docloginPage);
                  },
                  icon: Image.asset(
                    "assets/images/doc_logo.png",
                    height: 50,
                  ),
                  label: Text(
                    "Log in/SignUp As a Doctor",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                height: 70,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(20),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.patientLogin);
                  },
                  icon: Image.asset(
                    "assets/images/patient.png",
                    height: 50,
                  ),
                  label: Text(
                    "Log in/SignUp As a Patient",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
