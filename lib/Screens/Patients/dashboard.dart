import 'dart:convert';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:health_ai/utils/routes.dart';
import 'package:http/http.dart' as http;

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _DashboardState();
}

class _DashboardState extends State<PatientDashboard> {
  var name;
  var updateName;
  @override
  void initState() {
    super.initState();
    SignIn(); // call your function here
    // signIn.then((value) {
    //   // do something after the function completes
    // });
  }

  Future SignIn() async {
    //encode in base64

    final Uri uri = Uri.parse(
        'http://59e8-2409-4040-d94-94bc-c27-13c3-7df8-dcac.ngrok-free.app/users/name');
    var request = http.Request('POST', uri);

    final Map<String, String> headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJOM0daQVpNUU0wIiwiZXhwIjoxNjgxNjEzOTQ5fQ.iJV7aoJljZnpXof3YC3ut6tj6oVg4C8g2os1DCYxJ1I',
      'Content-Type': 'application/json',
    };

    final http.Response response = await http.post(uri, headers: headers);
    // final authorizationHeaderValue =
    //     'Bearer ' + response.body.substring(47, response.body.length - 2);
    // print(authorizationHeaderValue);
    name = jsonDecode(response.body);
    updateName = name["name"].toString();
  }

  @override
  Widget build(BuildContext context) {
    List<Map> users = [
      {
        "name": "Pavan Gole",
        "subtitle": "View your patients lab Analysis",
        "icon": "assets/files/lab_result.json",
      },
      {
        "name": "Arshad Mehta",
        "subtitle": "View your patients lab Analysis",
        "icon": "assets/files/lab_result.json",
      },
      {
        "name": "Prathamesh bro",
        "subtitle": "View your patients lab Analysis",
        "icon": "assets/files/lab_result.json",
      },
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Text(
                    "👋 Hi $updateName",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  //color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Image.asset("assets/images/doc_logo.png"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                "Welcome",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed(MyRoutes.scanningReportPateint),
                child: CommonWidget(Icons.search, 'Scan for disease'),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(MyRoutes.patientHistory),
                child: CommonWidget(Icons.mail, 'See recent reports'),
              ),
              CommonWidget(Icons.phone, 'Contact Doctor'),
            ],
          )
        ],
      ),
    );
  }
}

class CommonWidget extends StatelessWidget {
  final icon;
  final text;

  CommonWidget(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(6),
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(
                    icon,
                    size: 24,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios_sharp),
          ],
        ),
      ),
    );
  }
}
