import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/views/SignUpModule/period_length_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectPeriodDateView extends StatefulWidget {
  const SelectPeriodDateView({Key? key}) : super(key: key);

  @override
  _SelectPeriodDateViewState createState() => _SelectPeriodDateViewState();
}

class _SelectPeriodDateViewState extends State<SelectPeriodDateView> {
  bool clicked = false;
  DateTime date = DateTime.now();
  DateTime tableDate = DateTime.now();
  DateTime? chooseDate;
  final con = Get.find<SignUpController>();
  // DateTime? picker;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(chooseDate);
  }

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
              : SizeConfig.screenHeight * 1.8,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: appBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizeConfig.verticalSpaceLarge,
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.screenHeightPercentage(percentage: 15),
                  right: 40,
                  left: 40,
                ),
                child: Text(
                  LocaleKeys.when_was_the_first_period.tr(),
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
                  top: 4,
                  left: 30,
                  right: 30,
                ),
                child: container(
                  width: 100,
                  height: SizeConfig.screenOrientation == Orientation.portrait
                      ? SizeConfig.screenWidthPercentage(percentage: 16)
                      : 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TableCalendar(
                          shouldFillViewport: true,
                          firstDay: DateTime(tableDate.year - 1,
                              tableDate.month, tableDate.day),
                          lastDay: DateTime(
                              tableDate.year, tableDate.month, tableDate.day),
                          focusedDay: date,
                          onDaySelected: (value, d) {
                            print(chooseDate);
                            setState(() {
                              chooseDate = value;
                              date = d;
                            });
                          },
                          // calendarStyle: CalendarStyle(),
                          headerStyle: const HeaderStyle(
                              formatButtonVisible: false, titleCentered: true),
                          calendarBuilders: CalendarBuilders(
                            selectedBuilder: (context, date, events) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: radioColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      date.day.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                            todayBuilder: (context, date, _) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: radioColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: radioColor.withOpacity(0.3))),
                                  child: Center(
                                    child: Text(DateTime.now().day.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                radioColor.withOpacity(0.8))),
                                  ),
                                ),
                              );
                            },
                          ),
                          selectedDayPredicate: (day) => isSameDay(day, date),
                        ),
                      ),
                      Divider(color: Colors.black),
                      GestureDetector(
                          onTap: () {
                            // var time =
                            //     DateTime.parse("0000-00-00T00:00:00.000Z");
                            // con.date =
                            //     DateTime(time.year, time.month, time.day);
                            Navigator.push(
                              context,
                              PageTransition(
                                child: const PeriodLengthView(),
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 500),
                              ),
                            );
                          },
                          child: Text(
                            LocaleKeys.i_dont_remember.tr(),
                            style: TextStyle(fontSize: 15, wordSpacing: 2),
                          )),
                    ],
                  ),
                ),
              ),
              SizeConfig.verticalSpaceRegular,
              myButton(
                clicked: clicked,
                buttonText: LocaleKeys.Button_next_button.tr(),
                onPressed: () {
                  // if (chooseDate != null) {
                  con.date = chooseDate;
                  setState(() {
                    clicked = !clicked;
                  });
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const PeriodLengthView(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
                  // } else {
                  //   alertBox(
                  //       context: context,
                  //       errorText:
                  //           'Please select a date and then press Next to continue');
                  // }
                },
              ),
              // SizeConfig.verticalSpaceRegular,
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: myBottom(showGirl: false),
              ),
              // SizeConfig.verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }
}
