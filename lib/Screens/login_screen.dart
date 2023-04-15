// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;

  void handleChange() {
    setState(() {
      isLogin = !isLogin;
    });
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
                  isLogin ? 'Login' : 'Sign Up',
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
              if (!isLogin)
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
              if (isLogin)
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
                  onPressed: () {},
                  child: Text(isLogin ? 'Login' : 'Sign Up'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin
                        ? 'Don\'t have an account?'
                        : 'Already Have an account?',
                    style: TextStyle(
                      color: Color(0xff432C81),
                    ),
                  ),
                  TextButton(
                    onPressed: handleChange,
                    child: Text(
                      isLogin ? 'Sign Up' : 'Login',
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
