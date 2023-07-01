import 'package:flutter/material.dart';
import 'package:healthai/colors.dart';
import 'package:healthai/features/auth/screen/common/doctor_or_patient.dart';
import 'package:healthai/features/auth/widgets/onboarding_ui.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  // Future controller() async {
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: PageView(
            onPageChanged: (index) {
              if (index == 3) {
                setState(() {
                  isLastPage = true;
                });
              } else {
                setState(() {
                  isLastPage = false;
                });
              }
            },
            controller: _controller,
            children: const [
              OnBoardingUi(
                title: "Discover Top Doctors",
                description:
                    "In addition to our advanced diagnostic capabilities, our app also helps you find the most skilled and trusted doctors in your area.",
                image: "assets/images/doctor1.png",
              ),
              OnBoardingUi(
                title: "Ask a Doctor Online",
                description:
                    "You can ask a doctor online through our app. Our platform allows you to connect with experienced healthcare professionals from various specialties.",
                image: "assets/images/doctor2.png",
              ),
              OnBoardingUi(
                title: "Get Expert Advice",
                description:
                    "They will be able to address your medical concerns, provide expert advice, and guide you towards the most appropriate course of action for your health.",
                image: "assets/images/doctor3.png",
              ),
              OnBoardingUi(
                title: "Welcome to health.Ai",
                description:
                    "Take advantage of the convenience and accessibility of our app to get professional medical assistance from the comfort of your home.",
                image: "assets/images/doctor3.png",
              ),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: tabColor,
                  minimumSize: const Size(double.infinity, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, DoctorOrPatient.routeName);
                },
                child: const Text(
                  "Get Started!",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                height: 160,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () => _controller.animateToPage(
                        3,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                      ),
                      child: const Text(
                        "Skip Tour",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: tabColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: 4,
                        effect: const ExpandingDotsEffect(spacing: 10),
                        onDotClicked: (index) {
                          _controller.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
