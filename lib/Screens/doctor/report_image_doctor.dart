import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ReportImageDoctor extends StatelessWidget {
  const ReportImageDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(20),
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
