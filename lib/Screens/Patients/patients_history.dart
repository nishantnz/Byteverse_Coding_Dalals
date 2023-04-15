// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:health_ai/Screens/Patients/widgets/medical_history_item.dart';
import 'package:health_ai/utils/routes.dart';

class PatientsHistory extends StatelessWidget {
  var dummyData = [
    {
      'day': "friday",
      'report': "no cancer",
    },
    {
      'day': "thursday",
      'report': "no tumor",
    },
    {
      'day': "wednesday",
      'report': "no eye disease",
    },
    {
      'day': "monday",
      'report': "yes cancer",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              margin: EdgeInsets.all(10),
              color: Color(0x00432C81),
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
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0x00432C81),
              ),
              height: 400,
              child: ListView.builder(
                itemBuilder: (context, index) => MedicalHistoryItem(
                  dummyData[index]["day"],
                  dummyData[index]["report"],
                ),
                itemCount: dummyData.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
