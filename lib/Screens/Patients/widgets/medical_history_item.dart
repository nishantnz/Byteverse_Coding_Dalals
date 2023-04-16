// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:health_ai/utils/routes.dart';

class MedicalHistoryItem extends StatelessWidget {
  final day;
  final report;

  MedicalHistoryItem(this.day, this.report);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(MyRoutes.patientDetailedReportScreen);
        },
        child: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Color(0x28432C81),
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 2.5, left: 10),
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff432C81),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2.5, bottom: 5, left: 10),
                child: Text(
                  report,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff432C81),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
