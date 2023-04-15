import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_ai/widgets/onboardingUi.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});

  final PageController _controller = PageController();

  // Future controller() async {
  //   await _controller.animateToPage(1,
  //       duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  // }

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
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: 160,
          child: Column(
            children: [
              TextButton(
                onPressed: () => _controller.animateToPage(2,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut),
                child: const Text("Skip Tour",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
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
