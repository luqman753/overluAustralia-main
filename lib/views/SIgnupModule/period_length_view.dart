import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/views/SignUpModule/energy_fat_cal_view.dart';
import 'package:page_transition/page_transition.dart';

class PeriodLengthView extends StatefulWidget {
  const PeriodLengthView({Key? key}) : super(key: key);

  @override
  _PeriodLengthViewState createState() => _PeriodLengthViewState();
}

class _PeriodLengthViewState extends State<PeriodLengthView> {
  int value = 28;
  bool clicked = false, choose = false;
  final con = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: SizeConfig.screenOrientation == Orientation.portrait
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: SizeConfig.screenOrientation == Orientation.portrait
              ? SizeConfig.screenHeight
              : SizeConfig.screenHeight * 1.3,
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
                  LocaleKeys.average_cycle.tr(),
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
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  top: 50,
                ),
                child: container(
                  height: SizeConfig.screenOrientation == Orientation.portrait
                      ? 25
                      : 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                value -= 1;
                                choose = true;
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(child: Icon(Icons.remove)),
                            ),
                          ),
                          Text(
                            '$value',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: radioColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                value += 1;
                                choose = true;
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(child: Icon(Icons.add)),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black),
                      GestureDetector(
                        onTap: () {
                          // con.averagePeriodCycle.value = '0';
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const EngerFatCalculationView(),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: Text(
                          LocaleKeys.i_dont_know.tr(),
                          style: TextStyle(fontSize: 15, wordSpacing: 2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              myButton(
                clicked: clicked,
                buttonText: LocaleKeys.Button_next_button.tr(),
                onPressed: () {
                  // if (choose) {
                  con.averagePeriodCycle.value = value.toString();
                  setState(() {
                    clicked = !clicked;
                  });
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const EngerFatCalculationView(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
                  // } else {
                  //   alertBox(
                  //       context: context,
                  //       errorText:
                  //           'Please enter the number of days in your cycle and then press Next to continue');
                  // }
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
