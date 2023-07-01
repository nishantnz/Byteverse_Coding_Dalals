import 'package:flutter/material.dart';
import 'package:healthai/colors.dart';

class OnBoardingUi extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnBoardingUi({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        child: Center(
          child: Column(
            children: [
              // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Image.asset(
                image,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              const SizedBox(height: 30),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: tabColor,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: "Poppins", fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
