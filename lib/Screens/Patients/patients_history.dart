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
    {
      'day': "moonday",
      'report': "yes cancer",
    },
    {
      'day': "monday",
      'report': "yesss cancer",
    },
    {
      'day': "monday",
      'report': "yesss cancer",
    },
    {
      'day': "monday",
      'report': "yesss cancer",
    },
    {
      'day': "monday",
      'report': "yesss cancer",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // margin: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 60, right: 10, left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0x44432C81),
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
              margin: EdgeInsets.only(
                top: 15,
                bottom: 10,
                left: 10,
                right: 10,
              ),
              height: dummyData.length * 100 + 5.0 > 450
                  ? 5.3 * 100 + 5.0
                  : dummyData.length * 100 + 5.0,
              child: ListView.builder(
                itemBuilder: (context, index) => MedicalHistoryItem(
                  dummyData[index]["day"],
                  dummyData[index]["report"],
                ),
                itemCount: dummyData.length,
              ),
            ),
            Center(
              child: FloatingActionButton(
                backgroundColor: Colors.deepPurpleAccent[100],
                onPressed: () => Navigator.of(context).pushNamed(MyRoutes.addPatientDisease),
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
