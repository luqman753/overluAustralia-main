import 'dart:convert';

import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/views/SIgnupModule/sign_up_view.dart';
import 'package:ovulu/views/dashboard/follicular.dart';
import 'package:ovulu/views/dashboard/ovlutary.dart';
import 'package:ovulu/views/dashboard/time.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'menustral.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var jsonData;
  getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? basicAuthId = prefs.getString("basicAuth");
    String? recordId = prefs.getString('userRecordId');

    String now = DateFormat("dd-MM-yyyy").format(DateTime.now());

    String? link =
        "https://ovulu.thedatabase.net/api/ovulucustomerphase?CustomerRecordID=$recordId&DateForPhaseCalc=$now";
    // 67618817

    // $now";
    // "${getCloudUrl()}​​/api​/ShipmentOrder​/unpaidOrders";

    var url = Uri.parse(link);
    var response = await http.get(
      url,
      headers: {
        "Authorization": basicAuthId!,
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {});
      return jsonData;
    } else {
      print("Exception");
      throw Error;
    }
  }

  Future? futureList;
  @override
  void initState() {
    super.initState();
    futureList = getState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomNavLayout(
        // The app's destinations
        pages: [
          (_) => FutureBuilder(
              future: futureList,
              builder: (ctx, snapshot) {
                // Checking if future is resolved
                if (snapshot.connectionState == ConnectionState.done) {
                  // If we got an error
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: TextStyle(fontSize: 18),
                      ),
                    );

                    // if we got our data
                  } else if (snapshot.hasData) {
                    // Extracting data from snapshot object

                    return jsonData["PhaseInfo"][0]["Customer Current Phase"] ==
                            "Follicular"
                        ? Follicular()
                        : jsonData["PhaseInfo"][0]["Customer Current Phase"] ==
                                "Menstrual"
                            ? Menustral()
                            : jsonData["PhaseInfo"][0]
                                        ["Customer Current Phase"] ==
                                    "Ovulatory"
                                ? Ovlutary()
                                : Time();
                  }
                }

                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: const Center(child: SizedBox()),
                );
              }),
          //  Follicular(),
          // Ovlutary(),
          // Menustral(),
          // Time(),

          (_) => GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('userLoggedIn', false);
                prefs.setString('userRecordId', '');
                Get.offAll(() => const SignUpView(),
                    transition: Transition.topLevel);
              },
              child:
                  Center(child: const Text("Tap to Logout Just for testing"))),

          (_) => Center(child: Text("And this is something i don\'t know.")),
        ],
        bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => onTap(index),
          items: [
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage(
                  personHeadPic,
                ),
                height: 50,
                width: 50,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage(
                  calendarPic,
                ),
                height: 50,
                width: 50,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage(
                  logoSmallPic,
                ),
                height: 50,
                width: 50,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
