import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PatientsHandling extends StatelessWidget {
  const PatientsHandling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Text("This is Patients Handling Page"),
        ),
      ),
    );
  }
}
