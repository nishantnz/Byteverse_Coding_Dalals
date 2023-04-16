// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_ai/utils/routes.dart';
import 'package:http/http.dart' as http;

class PatientLoginScreen extends StatelessWidget {
  PatientLoginScreen({super.key});

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  var token;

  Future SignIn() async {
    //encode in base64
    final String email = emailEditingController.text;
    final String password = passwordEditingController.text;
    final String credentials = base64.encode(utf8.encode('$email:$password'));
    final Uri uri = Uri.parse(
        'http://e63b-2409-4040-d94-94bc-c27-13c3-7df8-dcac.ngrok-free.app/auth/login');
    var request = http.Request('POST', uri);

    final Map<String, String> headers = {
      'Authorization': 'Basic $credentials',
      'Content-Type': 'application/json',
    };

    final http.Response response = await http.post(uri, headers: headers);
    final authorizationHeaderValue =
        'Bearer ' + response.body.substring(47, response.body.length - 2);
    // print(authorizationHeaderValue);
    // print(response.body.toString());
    token = authorizationHeaderValue;
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                  "User Login",
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
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: null,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xff432C81),
                    ),
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

                    Navigator.pushNamed(context, MyRoutes.patientMainPage);
                  },
                  child: Text('Login'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Color(0xff432C81),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.patientSignUp);
                    },
                    child: Text(
                      'Sign Up',
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
