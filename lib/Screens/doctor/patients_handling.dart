import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_ai/utils/routes.dart';
import 'package:lottie/lottie.dart';

class PatientsHandling extends StatefulWidget {
  const PatientsHandling({super.key});

  @override
  State<PatientsHandling> createState() => _PatientsHandlingState();
}

class _PatientsHandlingState extends State<PatientsHandling> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> userdata = {
      "Scheduling Patients": "assets/files/patient_hist.json",
      //  "Patients History": "assets/files/scheduling_patients.json",
      "Scan Xray Images": "assets/files/xrayscan.json",
      "Scan CT Images": "assets/files/ctscan.json",
      "Scan MRI Images": "assets/files/mri.json",
    };

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
                  child: Text("Review Your Patients",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 15,
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
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: userdata.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 1.5),
                  itemBuilder: (BuildContext context, int index) {
                    String key = userdata.keys.elementAt(index);
                    String value = userdata.values.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        if (userdata.keys.elementAt(index) ==
                            "Scan Xray Images")
                          Navigator.pushNamed(context, MyRoutes.xraydoc);
                        else if (userdata.keys.elementAt(index) ==
                            "Scan CT Images")
                          Navigator.pushNamed(context, MyRoutes.ctdoc);
                        else if (userdata.keys.elementAt(index) ==
                            "Scan MRI Images")
                          Navigator.pushNamed(context, MyRoutes.mridoc);
                        else if (userdata.keys.elementAt(index) ==
                            "Scheduling Patients")
                          Navigator.pushNamed(
                              context, MyRoutes.scheduling_patients);
                      },
                      child: GridTile(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                child: Lottie.asset(value,
                                    repeat: false,
                                    animate: true,
                                    fit: BoxFit.contain),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  key,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
