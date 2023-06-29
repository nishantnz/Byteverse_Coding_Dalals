import 'package:flutter/material.dart';
import 'package:healthai/features/auth/screen/doctor/doctor_auth_screen.dart';
import 'package:healthai/features/auth/screen/patient/patient_auth_screen.dart';

class DoctorOrPatient extends StatelessWidget {
  static const routeName = '/docPatient';
  const DoctorOrPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              SizedBox(
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
                    Navigator.pushNamed(context, DoctorAuth.routeName);
                  },
                  icon: Image.asset(
                    "assets/images/doc_logo.png",
                    height: 50,
                  ),
                  label: const Text(
                    "Log in/SignUp As a Doctor",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
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
                    Navigator.pushNamed(context, PatientAuth.routeName);
                  },
                  icon: Image.asset(
                    "assets/images/patient.png",
                    height: 50,
                  ),
                  label: const Text(
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
