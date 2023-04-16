// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:health_ai/Screens/Patients/widgets/medical_history_item.dart';
import 'package:http/http.dart' as http;
import 'package:health_ai/utils/routes.dart';

class PatientsHistory extends StatefulWidget {
  // var dummyData = [
  @override
  State<PatientsHistory> createState() => _PatientsHistoryState();
}

class _PatientsHistoryState extends State<PatientsHistory> {
  void getPatientHistory() async {
    final Uri uri = Uri.parse(
        'http://9886-2409-4040-d94-94bc-c27-13c3-7df8-dcac.ngrok-free.app/users/history');
    var request = http.Request('POST', uri);

    final Map<String, String> headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJOM0daQVpNUU0wIiwiZXhwIjoxNjgxNjEzOTQ5fQ.iJV7aoJljZnpXof3YC3ut6tj6oVg4C8g2os1DCYxJ1I',
      'Content-Type': 'application/json',
    };

    final http.Response response = await http.post(uri, headers: headers);
    print(response.body);
  }

  @override
  void initState() {
    super.initState();
    getPatientHistory();
  }

  var dummyData = [];

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
                onPressed: () =>
                    Navigator.of(context).pushNamed(MyRoutes.addPatientDisease),
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
