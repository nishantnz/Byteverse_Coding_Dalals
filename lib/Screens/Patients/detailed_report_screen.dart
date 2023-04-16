// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class DetailedReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, String> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    String id = data['id']!;
    String disease = data['disease']!;
    String image = data['img']!;
    String pid = data['patientId']!;
    String path =
        'http://9886-2409-4040-d94-94bc-c27-13c3-7df8-dcac.ngrok-free.app/storage/$pid/processed/$image';
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Report Screen'),
      ),
      body: Column(
        children: [
          Text(
            'Report ID: $id',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Results: $disease',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Pid: $pid',
            style: TextStyle(fontSize: 20),
          ),
            
        ],
      ),
    );
  }
}
