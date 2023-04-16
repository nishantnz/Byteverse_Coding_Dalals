import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_ai/utils/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                "Check the Patient's Lab Scans/Results",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, MyRoutes.doctorPatientLabAnalysis);
                    },
                    child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: ListTile(
                        title: Text(
                          users[index]['name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          users[index]['subtitle'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Lottie.asset(
                          users[index]['icon'],
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
