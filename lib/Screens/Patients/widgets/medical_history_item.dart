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
      height: 75,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(MyRoutes.patientDetailedReportScreen);
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 2.5, left: 10),
                  child: Text(
                    day,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2.5, bottom: 5, left: 10),
                  child: Text(
                    report,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
