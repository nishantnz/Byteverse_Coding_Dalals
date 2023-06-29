import 'package:flutter/material.dart';

class ReportImageDoctor extends StatelessWidget {
  const ReportImageDoctor({super.key});

  static const routeName = '/report-image-doctor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(20),
            minScale: 0.1,
            maxScale: 4.0,
            child: Image.asset(
              "assets/images/xray.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
