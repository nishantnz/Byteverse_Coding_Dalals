// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class PatientsHistory extends StatelessWidget {
  const PatientsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Card(
              elevation: 2,
              margin: EdgeInsets.all(10),
              color: Color(0x18432C81),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Medical History',
                    style: TextStyle(
                        color: Color(0xff432C81),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Image.asset('assets/images/history1.png'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
