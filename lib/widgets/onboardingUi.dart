import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class OnBoardingUi extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  OnBoardingUi(
      {required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
      child: Center(
        child: Column(
          children: [
            // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Image.asset(
              image,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 2.5,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            Text(
              title,
              style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              description,
              style: const TextStyle(fontFamily: "Poppins", fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
