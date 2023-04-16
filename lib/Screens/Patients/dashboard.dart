// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
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
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwNVVJWFc2VkpCIiwiZXhwIjoxNjgxNjQ2OTc5fQ.aMyuUtWMTb1s78ihn44LTd5bXaL1OH-6JFe6mdncEZA',
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
        "name": "Arshad Mehta",
        "subtitle": "View your patients",
        "icon": "assets/files/patients.json",
      },
      {
        "name": "Pavan Gole",
        "subtitle": "View your patients lab results",
        "icon": "assets/files/lab_results.json",
      },
      {
        "name": "Prathamesh mast aadmi",
        "subtitle": "View your settings",
        "icon": "assets/files/settings.json",
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
                  child: Text("👋 Hi $updateName",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
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
          Expanded(
            child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
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
                    //trailing: users[index]['icon'],
                  );
                }),
          )
        ],
      ),
    );
  }
}
