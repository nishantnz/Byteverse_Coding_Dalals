import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_ai/utils/routes.dart';
import 'package:health_ai/widgets/onboardingUi.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  // Future controller() async {
  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: PageView(
            onPageChanged: (index) {
              if (index == 2) {
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
            children: [
              Container(
                child: OnBoardingUi(
                  title: "Discover Top Doctors",
                  description:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus lacinia libero ut metus convallis tempor. Vestibulum consequat, tortor mattis consequat",
                  image: "assets/images/doctor1.png",
                ),
              ),
              Container(
                child: OnBoardingUi(
                  title: "Ask a Doctor Online",
                  description:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus lacinia libero ut metus convallis tempor. Vestibulum consequat, tortor mattis consequat",
                  image: "assets/images/doctor2.png",
                ),
              ),
              Container(
                child: OnBoardingUi(
                  title: "Get Expert Advice",
                  description:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus lacinia libero ut metus convallis tempor. Vestibulum consequat, tortor mattis consequat",
                  image: "assets/images/doctor3.png",
                ),
              ),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size(double.infinity, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.doctorOrPatient);
                },
                child: Text(
                  "Get Started!",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                height: 160,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () => _controller.animateToPage(2,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut),
                      child: const Text(
                        "Skip Tour",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: const ExpandingDotsEffect(spacing: 10),
                        onDotClicked: (index) {
                          _controller.animateToPage(index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
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
