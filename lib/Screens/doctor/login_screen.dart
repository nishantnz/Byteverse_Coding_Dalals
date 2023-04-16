// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_ai/utils/routes.dart';
import 'package:http/http.dart' as http;

class DoctorLoginScreen extends StatefulWidget {
  DoctorLoginScreen({super.key});

  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final emailEditingController = TextEditingController();

  final passwordEditingController = TextEditingController();

  var tok;

  Future SignIn() async {
    //encode in base64
    final String email = emailEditingController.text;
    final String password = passwordEditingController.text;
    final String credentials = base64.encode(utf8.encode('$email:$password'));
    final Uri uri =
        Uri.parse('http://healthai.koreacentral.cloudapp.azure.com/auth/login');
    var request = http.Request('POST', uri);

    final Map<String, String> headers = {
      'Authorization': 'Basic c2F2YW5AZ21haWwuY29tOnBhdmFu',
      'Content-Type': 'application/json',
    };

    final http.Response response = await http.post(uri, headers: headers);

    print(response.body.toString());
    setState(() {
      tok = jsonDecode(response.body.substring(29, response.body.length - 2));
    });
  }

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
                  "Doctor Login",
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
                    if (tok != null) {
                      Navigator.pushNamed(context, MyRoutes.mainPage);
                    }
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
                      Navigator.pushNamed(context, MyRoutes.docSignUp);
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
