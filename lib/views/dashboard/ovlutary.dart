// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'dart:convert';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ovulu/controllers/sign_in_controller.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Ovlutary extends StatefulWidget {
  const Ovlutary({Key? key}) : super(key: key);

  @override
  _OvlutaryState createState() => _OvlutaryState();
}

class _OvlutaryState extends State<Ovlutary> {
  List days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'];
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'Jun',
    'July',
    'August',
    'September',
    'Octobber',
    'November',
    'December'
  ];
  String? basicAuthId;
  int touch = 0;
  var jsonData;
  int tabTips = 0;
  Future? listData;
  getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    basicAuthId = prefs.getString("basicAuth");
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
      var sun =
          date.subtract(Duration(days: date.weekday % DateTime.daysPerWeek));
      var lasDay = date
          .subtract(Duration(days: date.weekday % DateTime.daysPerWeek))
          .add(const Duration(days: DateTime.daysPerWeek - 1));
      for (int i = 0; i <= lasDay.difference(sun).inDays; i++) {
        //  dateDays=sun.add(Duration(days: i))
        daying.add(sun.add(Duration(days: i)));
        String sum = DateFormat("dd").format(daying[i]);
        dateDays.add(sum);
      }

      jsonData = json.decode(response.body);

      return jsonData;
    } else {
      print("Exception");
      throw Error;
    }
  }

  List<DateTime> daying = [];
  List<String> dateDays = [];
  String? nowDate;
  @override
  void initState() {
    super.initState();
    listData = getState();
    var now = DateTime.now();
    nowDate = DateFormat("dd").format(now);
    setState(() {});
  }

  int currentMonth = DateTime.now().month;
  DateTime date = DateTime.now();
  final con = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    print(currentMonth);
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: listData,
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
                        return Container(
                          color: Colors.white,
                          //appBackgroundColor.withOpacity(0.1),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeConfig.screenWidthPercentage(
                                                  percentage: 24),
                                          top:
                                              SizeConfig.screenHeightPercentage(
                                                  percentage: 1)),
                                      child: Text(
                                        months[currentMonth - 1],
                                        style: TextStyle(
                                            color: textColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                        left: SizeConfig.screenWidthPercentage(
                                            percentage: 20),
                                      ),
                                      child: Image(
                                        image: AssetImage(calendarPic),
                                        height: 40,
                                        width: 40,
                                      ))
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height:
                                            SizeConfig.screenHeightPercentage(
                                                percentage: 4.3),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          height:
                                              SizeConfig.screenWidthPercentage(
                                                  percentage: 6),
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 7,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      right: SizeConfig
                                                          .screenWidthPercentage(
                                                              percentage: 2),
                                                      left: SizeConfig
                                                          .screenWidthPercentage(
                                                              percentage:
                                                                  4.2222)),
                                                  child: Row(children: [
                                                    Text(
                                                      days[index].toString(),
                                                      style: TextStyle(
                                                          color: textColor,
                                                          fontSize: 18),
                                                    ),
                                                  ]),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeightPercentage(
                                        percentage: 2),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          height:
                                              SizeConfig.screenWidthPercentage(
                                                  percentage: 8),
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 7,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      left: SizeConfig
                                                          .screenWidthPercentage(
                                                              percentage: 8.4)),
                                                  child: Column(children: [
                                                    Row(
                                                      children: [
                                                        dateDays[index] ==
                                                                nowDate
                                                            ? Container(
                                                                height: SizeConfig
                                                                    .screenHeightPercentage(
                                                                        percentage:
                                                                            3.2),
                                                                width: SizeConfig
                                                                    .screenWidthPercentage(
                                                                        percentage:
                                                                            8),
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        ovlutaryText,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100)),
                                                                child: Center(
                                                                  child: Text(
                                                                    dateDays[
                                                                            index]
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18,
                                                                      // decoration: TextDecoration.underline,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Text(
                                                                dateDays[index]
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      ovlutaryText,
                                                                  fontSize: 18,
                                                                  // decoration: TextDecoration.underline,
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ]),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: dateDays[0] == nowDate
                                            ? EdgeInsets.only(
                                                left: SizeConfig.screenWidthPercentage(
                                                    percentage: 6))
                                            : dateDays[1] == nowDate
                                                ? EdgeInsets.only(
                                                    left:
                                                        SizeConfig.screenWidthPercentage(
                                                            percentage: 20))
                                                : dateDays[2] == nowDate
                                                    ? EdgeInsets.only(
                                                        left: SizeConfig
                                                            .screenWidthPercentage(
                                                                percentage: 29))
                                                    : dateDays[3] == nowDate
                                                        ? EdgeInsets.only(
                                                            left: SizeConfig.screenWidthPercentage(
                                                                percentage: 47))
                                                        : dateDays[4] == nowDate
                                                            ? EdgeInsets.only(
                                                                left: SizeConfig.screenWidthPercentage(
                                                                    percentage:
                                                                        60))
                                                            : dateDays[5] ==
                                                                    nowDate
                                                                ? EdgeInsets.only(
                                                                    left: SizeConfig.screenWidthPercentage(percentage: 72))
                                                                : EdgeInsets.only(left: SizeConfig.screenWidthPercentage(percentage: 84)),
                                        child: Divider(
                                          height: 2,
                                          indent: 2,
                                          thickness: 2,
                                          color: ovlutaryText,
                                        ),
                                      )
                                      //  Image(
                                      //                image: AssetImage(linePic),
                                      //                height: SizeConfig.screenHeightPercentage(percentage:1)  ,
                                      //                  width: MediaQuery.of(context).size.width*1,
                                      //              ),
                                    ],
                                  )
                                ],
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        // left:SizeConfig.screenWidthPercentage(percentage:3.9),
                                        top: SizeConfig.screenHeightPercentage(
                                            percentage: 35.9),
                                        left: SizeConfig.screenHeightPercentage(
                                            percentage: 2.6)),
                                    child: Container(
                                      height: SizeConfig.screenHeightPercentage(
                                          percentage: 4.2),
                                      width: SizeConfig.screenWidthPercentage(
                                          percentage: 34.4),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          tabTips = 0;
                                          setState(() {});
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                // /Fcolor: Colors
                                                color: tabTips == 1
                                                    ? ovlutaryUnselected
                                                    : ovlutaryText,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
                                            child: Center(
                                              child: Text(
                                                "Today's Tips",
                                                style: TextStyle(
                                                    color: tabTips == 1
                                                        ? ovlutaryText
                                                        : ovlutaryUnselected,
                                                    fontSize: 22),
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.screenWidthPercentage(
                                            percentage: 39.6),
                                        top: SizeConfig.screenHeightPercentage(
                                            percentage: 35.9)),
                                    child: Container(
                                      height: SizeConfig.screenHeightPercentage(
                                          percentage: 4.2),
                                      width: SizeConfig.screenWidthPercentage(
                                          percentage: 33.3),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          tabTips = 1;
                                          setState(() {});
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(

                                                // /Fcolor: Colors

                                                color: tabTips == 0
                                                    ? ovlutaryUnselected
                                                    : ovlutaryText,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(
                                                                10))),
                                            child: Center(
                                              child: Text(
                                                "Phase Tips",
                                                style: TextStyle(
                                                    color: tabTips == 0
                                                        ? ovlutaryText
                                                        : ovlutaryUnselected,
                                                    fontSize: 22),
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.screenHeightPercentage(
                                            percentage: 40),
                                        left: SizeConfig.screenHeightPercentage(
                                            percentage: 2)),
                                    child: Container(
                                        // height: SizeConfig.screenHeightPercentage(percentage: ),
                                        width: SizeConfig.screenWidthPercentage(
                                            percentage: 75),
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: ovlutaryBox,
                                            // appBackgroundColor.withOpacity(0.4),
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(30),
                                                bottomLeft: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30))),
                                        child: tabTips == 0
                                            ? Column(
                                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.ac_unit,
                                                        color: ovlutaryText,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: SizeConfig
                                                                      .screenWidthPercentage(
                                                                          percentage:
                                                                              2),
                                                                  right: SizeConfig
                                                                      .screenWidthPercentage(
                                                                          percentage:
                                                                              6)),
                                                              child: Text(
                                                                jsonData["ParagraphList"]
                                                                        [0][
                                                                    "Tip dot point"],
                                                                style: TextStyle(
                                                                    color:
                                                                        ovlutaryText,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.ac_unit,
                                                        color: ovlutaryText,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: SizeConfig
                                                                      .screenWidthPercentage(
                                                                          percentage:
                                                                              2),
                                                                  right: SizeConfig
                                                                      .screenWidthPercentage(
                                                                          percentage:
                                                                              6)),
                                                              child: Text(
                                                                jsonData["ParagraphList"]
                                                                        [1][
                                                                    "Tip dot point"],
                                                                style: TextStyle(
                                                                    color:
                                                                        ovlutaryText,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.ac_unit,
                                                        color: ovlutaryText,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: SizeConfig
                                                                      .screenWidthPercentage(
                                                                          percentage:
                                                                              2),
                                                                  right: SizeConfig
                                                                      .screenWidthPercentage(
                                                                          percentage:
                                                                              6)),
                                                              child: Text(
                                                                jsonData["ParagraphList"]
                                                                        [2][
                                                                    "Tip dot point"],
                                                                style: TextStyle(
                                                                    color:
                                                                        ovlutaryText,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                            touch == 1
                                                                ? Container(
                                                                    // height: MediaQuery.of(
                                                                    //             context)
                                                                    //         .size
                                                                    //         .height *
                                                                    //     0.5,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        1,
                                                                    decoration:
                                                                        const BoxDecoration(),
                                                                    child:
                                                                        BackdropFilter(
                                                                      filter: ImageFilter.blur(
                                                                          sigmaX:
                                                                              7.0,
                                                                          sigmaY:
                                                                              7.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : SizedBox(),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: SizeConfig
                                                        .screenHeightPercentage(
                                                            percentage: 4),
                                                  )
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  touch == 1
                                                      ? Container(
                                                          // height: MediaQuery.of(
                                                          //             context)
                                                          //         .size
                                                          //         .height *
                                                          //     0.5,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              1,
                                                          decoration:
                                                              const BoxDecoration(),
                                                          child: BackdropFilter(
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX: 7.0,
                                                                    sigmaY:
                                                                        7.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.0)),
                                                            ),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding: EdgeInsets.only(
                                                              right: SizeConfig
                                                                  .screenWidthPercentage(
                                                                      percentage:
                                                                          6.2)),
                                                          child: Text(
                                                            jsonData[
                                                                    "PhaseInfo"]
                                                                [0]["Tab Tips"],
                                                            style: TextStyle(
                                                                fontSize: 11.5,
                                                                color:
                                                                    ovlutaryText),
                                                          ),
                                                        ),
                                                ],
                                              )),
                                  ),

                                  /////// Expanded Cloud
                                  touch == 1
                                      ? Positioned(
                                          top:
                                              SizeConfig.screenHeightPercentage(
                                                  percentage: -6),
                                          right:
                                              SizeConfig.screenWidthPercentage(
                                                  percentage: -12),
                                          child: Image(
                                            image: AssetImage(expandedCloud),
                                            height: SizeConfig
                                                .screenHeightPercentage(
                                                    percentage: 65),
                                            // width: SizeConfig.screenWidthPercentage(percentage: 50)/,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                  .screenWidthPercentage(
                                                      percentage: 15)),
                                          child: Image(
                                            image: AssetImage(ovulerayPic),
                                            height: SizeConfig
                                                .screenHeightPercentage(
                                                    percentage: 35),
                                            // fit: BoxFit.scover,
                                          ),
                                        ),
                                  touch == 1
                                      ? Positioned(
                                          top: SizeConfig.screenWidthPercentage(
                                              percentage: 20),
                                          left:
                                              SizeConfig.screenWidthPercentage(
                                                  percentage: 30),
                                          child: Text(
                                            "Ovlutary Phase",
                                            style: TextStyle(
                                                fontSize: 20,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: ovlutaryText),
                                          ),
                                        )
                                      : SizedBox(),
                                  touch == 1
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              top: SizeConfig
                                                  .screenWidthPercentage(
                                                      percentage: 80),
                                              left: SizeConfig
                                                  .screenWidthPercentage(
                                                      percentage: 25)),
                                          child: InkWell(
                                            onTap: () {
                                              touch = 0;
                                              setState(() {});
                                            },
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                    height: SizeConfig
                                                        .screenWidthPercentage(
                                                            percentage: 12),
                                                    width: SizeConfig
                                                        .screenWidthPercentage(
                                                            percentage: 40),
                                                    child: TextField(
                                                      style: TextStyle(
                                                        color: ovlutaryText,
                                                      ),
                                                      autofocus: false,
                                                      // obscureText: false,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        border:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none,
                                                          ),
                                                        ),
                                                        fillColor:
                                                            ovlutarySelected,
                                                        labelText: 'Add Note',
                                                        // labelText: TextDisplayConstants.EMAIL,
                                                        labelStyle: TextStyle(
                                                          color: follicularText,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: SizeConfig
                                                      .screenWidthPercentage(
                                                          percentage: 2),
                                                ),
                                                Container(
                                                  height: SizeConfig
                                                      .screenWidthPercentage(
                                                          percentage: 8),
                                                  width: SizeConfig
                                                      .screenWidthPercentage(
                                                          percentage: 15),
                                                  color: Colors.transparent,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              ovlutarySelected,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      child: Center(
                                                          child: Text(
                                                        "Add",
                                                        style: TextStyle(
                                                            color:
                                                                ovlutaryText),
                                                      ))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.screenWidthPercentage(
                                            percentage: 10),
                                        top: SizeConfig.screenHeightPercentage(
                                            percentage: 10)),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            touch = 1;
                                            setState(() {});
                                          },
                                          child: touch == 0
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: SizeConfig
                                                          .screenWidthPercentage(
                                                              percentage: 17),
                                                      top: SizeConfig
                                                          .screenHeightPercentage(
                                                              percentage: 3)),
                                                  child: Text(
                                                    "Ovulatory Phase",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color: ovlutaryText),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ),
                                        touch == 0
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    top: 8,
                                                    left: SizeConfig
                                                        .screenWidthPercentage(
                                                            percentage: 21)),
                                                child: Text(
                                                  "Day " +
                                                      jsonData["PhaseInfo"][0]
                                                              ["PhaseDayNum"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: ovlutaryText),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              SizeConfig.screenHeightPercentage(
                                                  percentage: 38.5)),
                                      child: SizedBox(
                                        height:
                                            SizeConfig.screenHeightPercentage(
                                                percentage: 30),
                                        width: SizeConfig.screenWidthPercentage(
                                            percentage: 128),
                                      )
                                      // myBottom(
                                      //     showGirl: true, showLogo: false),
                                      ),
                                  ////Expanded cloud text
                                  touch == 1
                                      ? SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: SizeConfig
                                                      .screenWidthPercentage(
                                                          percentage: 23),
                                                  right: SizeConfig
                                                      .screenWidthPercentage(
                                                          percentage: 19),
                                                  top: SizeConfig
                                                      .screenHeightPercentage(
                                                          percentage: 15)),
                                              child: ListView.builder(
                                                  itemCount: 1,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Text(
                                                        jsonData["PhaseInfo"][0]
                                                                ["Cloud Tips"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 15.5,
                                                            color:
                                                                ovlutaryText));
                                                  })),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              //// Scroll text
                              tabTips == 0
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeConfig.screenWidthPercentage(
                                                  percentage: 2),
                                          right:
                                              SizeConfig.screenWidthPercentage(
                                                  percentage: 20)),
                                      child: Text(
                                        jsonData["ParagraphList"][0]
                                            ["Tip paragraph"],
                                        style: TextStyle(
                                            color: ovlutaryText, fontSize: 20),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        );
                      }
                    }

                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.5),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeightPercentage(percentage: 60)),
            child: myBottom(showGirl: true, showLogo: false),
          ),
        ],
      ),
    );
  }
}