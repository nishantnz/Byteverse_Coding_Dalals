// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class DetailedReportScreen extends StatelessWidget {
  const DetailedReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Report Screen'),
      ),
      body: Column(
        children: [
          Text(
            'Report ID: ',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Report for: ',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Results: ',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Image: ',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
