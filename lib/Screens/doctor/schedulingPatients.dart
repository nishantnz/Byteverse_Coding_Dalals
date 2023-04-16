import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_ai/utils/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class SchedulingPatients extends StatelessWidget {
  const SchedulingPatients({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> usersAppointMent = [
      {
        "name": "Pavan Gole",
        "subtitle": DateFormat('EEE, MMM d, h:mm a').format(DateTime.now()),
        "icon": "assets/images/p1.jpg",
      },
      {
        "name": "Arshad Mehta",
        "subtitle": DateFormat('EEE, MMM d, h:mm a').format(DateTime.now()),
        "icon": "assets/images/p2.jpg",
      },
      {
        "name": "Prathamesh bro",
        "subtitle": DateFormat('EEE, MMM d, h:mm a').format(DateTime.now()),
        "icon": "assets/images/p3.jpeg",
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
                    "Todays Appointments",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 15,
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
                "You have 3 appointments today",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: usersAppointMent.length,
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
                          usersAppointMent[index]['name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          usersAppointMent[index]['subtitle'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: ClipOval(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                //color: Colors.black,

                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset(
                              usersAppointMent[index]['icon'],
                              fit: BoxFit.cover,
                            ),
                          ),
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
