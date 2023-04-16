// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:health_ai/utils/routes.dart';

class MedicalHistoryItem extends StatelessWidget {
  final day;
  final scan_type;
  final report;
  final id;
  final image;
  final patientId;

  MedicalHistoryItem(
    this.day,
    this.scan_type,
    this.id,
    this.image,
    this.patientId,
    this.report,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(MyRoutes.patientDetailedReportScreen, arguments: {
            'id': id.toString(),
            'img': image.toString(),
            'disease': report.toString(),
            'patientId': patientId.toString(),
            'scan_type': scan_type.toString(),
          });
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
                  scan_type,
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
