import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/designKit/src/widgets/my_filter.dart';
import 'package:ovulu/views/SignUpModule/thanks_view.dart';
import 'package:page_transition/page_transition.dart';

class EngerFatCalculationView extends StatefulWidget {
  const EngerFatCalculationView({Key? key}) : super(key: key);

  @override
  _EngerFatCalculationViewState createState() =>
      _EngerFatCalculationViewState();
}

class _EngerFatCalculationViewState extends State<EngerFatCalculationView> {
  int selectedIndex = 0;
  List<String> listOfDropDown = [
    LocaleKeys.activity_options_option1.tr(),
    LocaleKeys.activity_options_option2.tr(),
    LocaleKeys.activity_options_option3.tr(),
    LocaleKeys.activity_options_option4.tr(),
    LocaleKeys.activity_options_option5.tr(),
  ];
  String selectedText = 'Please select',
      height1 = '',
      weight = '',
      age = '',
      activity = '';
  bool heightClicked = false,
      clicked = false,
      weightClicked = false,
      ageClicked = false,
      validHeight = false,
      validWeight = false,
      validAge = false,
      validActivity = false;
  final con = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    double height = SizeConfig.screenHeight;
    double width = SizeConfig.screenWidth;
    // SizeConfig.screenOrientation == Orientation.portrait
    //     ? ScreenUtil.init(BoxConstraints(maxWidth: width, maxHeight: height),
    //         designSize: Size(width, height))
    //     : ScreenUtil .init(BoxConstraints(maxWidth: width, maxHeight: height),
    //         designSize: Size(width, height));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: SizeConfig.screenOrientation == Orientation.portrait
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: SizeConfig.screenOrientation == Orientation.portrait
              ? SizeConfig.screenHeight
              : SizeConfig.screenHeight * 1.5,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: appBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.screenHeightPercentage(percentage: 15),
                  right: 40,
                  left: 40,
                ),
                child: Text(
                  LocaleKeys.enter_height_age_activity_screen.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 3.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
                child: container(
                  height: SizeConfig.screenOrientation == Orientation.portrait
                      ? 38
                      : 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      myInput(
                          onTap: () {
                            setState(() {
                              heightClicked = true;
                              ageClicked = false;
                              weightClicked = false;
                            });
                          },
                          onChanged: (value) {
                            if (value.trim().length > 3 ||
                                value.trim().length < 3) {
                              setState(() {
                                validHeight = false;
                              });
                            } else {
                              setState(() {
                                height1 = value;
                                validHeight = true;
                              });
                            }
                          },
                          leadingTitle: LocaleKeys.height_height.tr(),
                          hintText: heightClicked
                              ? ''
                              : LocaleKeys.height_example.tr(),
                          trailingTitle: LocaleKeys.height_unit.tr()),
                      myInput(
                          onTap: () {
                            setState(() {
                              heightClicked = false;
                              ageClicked = false;
                              weightClicked = true;
                            });
                          },
                          onChanged: (value) {
                            if (value.trim().length > 2 ||
                                value.trim().length < 2) {
                              setState(() {
                                validWeight = false;
                              });
                            } else {
                              setState(() {
                                weight = value;
                                validWeight = true;
                              });
                            }
                          },
                          leadingTitle: LocaleKeys.weight_weight.tr(),
                          hintText: weightClicked
                              ? ''
                              : LocaleKeys.weight_example.tr(),
                          trailingTitle: LocaleKeys.weight_unit.tr()),
                      myInput(
                          onTap: () {
                            setState(() {
                              heightClicked = false;
                              ageClicked = true;
                              weightClicked = false;
                            });
                          },
                          onChanged: (value) {
                            if (value.trim().length > 2 ||
                                value.trim().length < 2) {
                              setState(() {
                                validAge = false;
                              });
                            } else {
                              setState(() {
                                age = value;
                                validAge = true;
                              });
                            }
                          },
                          leadingTitle: LocaleKeys.age_age.tr(),
                          hintText:
                              ageClicked ? '' : LocaleKeys.age_example.tr(),
                          trailingTitle: LocaleKeys.age_unit.tr()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: SizeConfig.screenOrientation ==
                                    Orientation.portrait
                                ? SizeConfig.screenHeightPercentage(
                                    percentage: 4)
                                : SizeConfig.screenHeightPercentage(
                                    percentage: 8),
                            width: SizeConfig.screenOrientation ==
                                    Orientation.portrait
                                ? SizeConfig.screenWidthPercentage(
                                    percentage: 18)
                                : SizeConfig.screenWidthPercentage(
                                    percentage: 12),
                            decoration: BoxDecoration(
                              color: radioColor,
                            ),
                            child: Center(
                              child: Text(
                                LocaleKeys.activity.tr(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                          myFilter(
                              hint: selectedText,
                              backgroundColor: Colors.white,
                              context: context,
                              listOfDropDownItem: listOfDropDown,
                              onChanged: (value) {
                                if (value == "Little to no exercise ") {
                                  setState(() {
                                    validActivity = true;
                                    selectedText = "Little to no exercise";
                                  });
                                } else if (value ==
                                    "Light exercise 1 – 3 times a week") {
                                  setState(() {
                                    validActivity = true;
                                    selectedText = "Light exercise";
                                  });
                                } else if (value ==
                                    "Moderate exercise 3 – 5 times a week") {
                                  setState(() {
                                    validActivity = true;
                                    selectedText = "Moderate exercise";
                                  });
                                } else if (value ==
                                    "Hard exercise or sport 6 – 7 times a week") {
                                  setState(() {
                                    validActivity = true;
                                    selectedText = "Hard exercise or sport";
                                  });
                                } else if (value ==
                                    "Extremely hard, daily exercise ") {
                                  setState(() {
                                    validActivity = true;
                                    selectedText = "Extremely hard";
                                  });
                                } else {}
                              }),
                        ],
                      ),
                      Divider(height: 2, color: Colors.black),
                      GestureDetector(
                          onTap: () {
                            // con.height.value = '';
                            // con.weight.value = '';
                            // con.age.value = '';
                            // con.activity.value = '0';
                            Navigator.push(
                              context,
                              PageTransition(
                                child: const ThanksView(),
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 500),
                              ),
                            );
                          },
                          child: Text(
                            LocaleKeys.i_would_rather_not_say.tr(),
                            style: TextStyle(fontSize: 15, wordSpacing: 2),
                          )),
                    ],
                  ),
                ),
              ),
              myButton(
                clicked: clicked,
                buttonText: LocaleKeys.Button_next_button.tr(),
                onPressed: () {
                  if (validHeight && validWeight && validAge && validActivity) {
                    con.height.value = height1;
                    con.weight.value = weight;
                    con.age.value = age;
                    con.activity.value =
                        listOfDropDown.indexOf(selectedText).toString();
                    // print(listOfDropDown.indexOf(selectedText));
                    setState(() {
                      clicked = !clicked;
                    });
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const ThanksView(),
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  }
                  // else if (!validHeight) {
                  //   alertBox(
                  //       context: context,
                  //       errorText: LocaleKeys.error_msg_height_error_msg.tr());
                  // } else if (!validWeight) {
                  //   alertBox(
                  //       context: context,
                  //       errorText: LocaleKeys.error_msg_weight_error_msg.tr());
                  // } else if (!validAge) {
                  //   alertBox(
                  //       context: context,
                  //       errorText: LocaleKeys.error_msg_age_error_msg.tr());
                  // }
                  else {
                    alertBox(
                        context: context,
                        errorText: LocaleKeys
                            .error_msg_height_age_activity_error_msg
                            .tr());
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: myBottom(showGirl: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
