import 'package:flutter/material.dart';
import 'package:healthai/common/enums/user_type_enum.dart';
import 'package:healthai/features/scans/screens/ct.dart';
import 'package:healthai/features/scans/screens/mri.dart';
import 'package:healthai/features/scans/screens/skin_disease.dart';
import 'package:healthai/features/scans/screens/xray.dart';
import 'package:lottie/lottie.dart';

class PatientAllScanPages extends StatelessWidget {
  const PatientAllScanPages({super.key});

  static const routeName = '/patient-all-scan-pages';

  @override
  Widget build(BuildContext context) {
    Map<String, String> userdata = {
      //  "Patients History": "assets/files/scheduling_patients.json",
      "Scan Xray Images": "assets/files/xrayscan.json",
      "Scan CT Images": "assets/files/ctscan.json",
      "Scan MRI Images": "assets/files/mri.json",
      "Scan Skin Images": "assets/files/xrayscan.json",
    };

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Patients",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  //color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Image.asset("assets/images/doc_logo.png"),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: userdata.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  String key = userdata.keys.elementAt(index);
                  String value = userdata.values.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      if (userdata.keys.elementAt(index) ==
                          "Scan Xray Images") {
                        Navigator.pushNamed(
                          context,
                          XRayScan.routeName,
                          arguments: UserTypeEnum.patient,
                        );
                      } else if (userdata.keys.elementAt(index) ==
                          "Scan CT Images") {
                        Navigator.pushNamed(
                          context,
                          CTScan.routeName,
                          arguments: UserTypeEnum.patient,
                        );
                      } else if (userdata.keys.elementAt(index) ==
                          "Scan MRI Images") {
                        Navigator.pushNamed(
                          context,
                          MRIScan.routeName,
                          arguments: UserTypeEnum.patient,
                        );
                      } else if (userdata.keys.elementAt(index) ==
                          "Scan Skin Images") {
                        Navigator.pushNamed(
                          context,
                          SkinDiseaseScan.routeName,
                          arguments: UserTypeEnum.patient,
                        );
                      }
                    },
                    child: GridTile(
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Lottie.asset(value,
                                  repeat: false,
                                  animate: true,
                                  fit: BoxFit.contain),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                key,
                                style: const TextStyle(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
