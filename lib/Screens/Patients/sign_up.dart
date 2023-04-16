// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_ai/utils/routes.dart';
import 'package:http/http.dart' as http;

class PatientSignUp extends StatelessWidget {
  PatientSignUp({super.key});

  Future SignIn() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
          'http://e63b-2409-4040-d94-94bc-c27-13c3-7df8-dcac.ngrok-free.app/auth/register'),
    );
    request.body = json.encode({
      "name": nameEditingController.text,
      "email": emailEditingController.text,
      "password": passwordEditingController.text,
      "role": "Patient"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      //print the response text
      print("YOYOYO");
    } else {
      print(response.reasonPhrase);
    }
  }

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final nameEditingController = TextEditingController();

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
                  "User Sign Up",
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff432C81),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(14),
                height: 327,
                width: 280,
                child: Image.asset('assets/images/login1.png'),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: nameEditingController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Full Name',
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
                  controller: emailEditingController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Email',
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
                  controller: passwordEditingController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Password',
                  ),
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
                    SignIn();

                    // Navigator.pushNamed(context, MyRoutes.getPatientData);
                  },
                  child: Text('Sign Up'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have an account?',
                    style: TextStyle(
                      color: Color(0xff432C81),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.patientLogin);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xff432C81),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
