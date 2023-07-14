import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/views/SignUpModule/select_period_date_view.dart';
import 'package:page_transition/page_transition.dart';

class CoMorbiditiesView extends StatefulWidget {
  const CoMorbiditiesView({Key? key}) : super(key: key);

  @override
  _CoMorbiditiesViewState createState() => _CoMorbiditiesViewState();
}

class _CoMorbiditiesViewState extends State<CoMorbiditiesView> {
  bool clicked = false;
  List<bool> selection = [false, false, false, false, false];
  List<String> selected = [];
  List<String> list = [
    LocaleKeys.coMorbidities_options_option1.tr(),
    LocaleKeys.coMorbidities_options_option2.tr(),
    LocaleKeys.coMorbidities_options_option3.tr(),
    LocaleKeys.coMorbidities_options_option4.tr(),
    LocaleKeys.coMorbidities_options_option5.tr(),
    // 'I would rather not say',
  ];
  final con = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);

    return Scaffold(
      body: SingleChildScrollView(
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
                  LocaleKeys.comorbidities_screen.tr(),
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
                padding: const EdgeInsets.all(40.0),
                child: container(
                  height: SizeConfig.screenOrientation == Orientation.portrait
                      ? 45
                      : 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      myRadio(text: list[0], index: 0),
                      myRadio(text: list[1], index: 1),
                      myRadio(text: list[2], index: 2),
                      myRadio(text: list[3], index: 3),
                      myRadio(text: list[4], index: 4),
                      // myRadio(text: list[5], index: 5),
                      Divider(color: Colors.black),
                      GestureDetector(
                        onTap: () {
                          con.listOfDiagnoses.value = '0';
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const SelectPeriodDateView(),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: Text(
                          LocaleKeys.i_would_rather_not_say.tr(),
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
                  if (selected.isNotEmpty) {
                    String ans = '';
                    if (!selection[4]) {
                      for (int i = 0; i < selection.length; i++) {
                        if (i < selection.length - 1) {
                          if (selection[i]) {
                            ans += i.toString();
                            if (selection[i + 1]) {
                              ans += ',';
                            }
                          }
                        }
                      }
                    } else {
                      ans = '0';
                    }
                    print('ANSWER--->>>$ans');
                    con.listOfDiagnoses.value = ans;
                    setState(() {
                      clicked = !clicked;
                    });
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const SelectPeriodDateView(),
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  } else {
                    alertBox(
                        context: context,
                        errorText: LocaleKeys
                            .error_msg_select_atleast_one_option_error_msg
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

  Widget myRadio({required String text, required int index}) {
    return GestureDetector(
      onTap: () {
        // print(selected);
        if (index == 4) {
          selection[0] = false;
          selection[1] = false;
          selection[2] = false;
          selection[3] = false;
          // selection[5] = false;
          selected.removeRange(0, selected.length);
          setState(() {
            // selected.add(list[4]);
            selection[index] = !selection[index];
          });
          if (selection[index]) {
            setState(() {
              selected.add(list[index]);
            });
          } else {
            setState(() {
              selected.remove(list[index]);
            });
          }
        } else {
          selection[4] = false;

          selected.removeWhere((item) => item.contains('None of the above'));

          if (!selection[index]) {
            setState(() {
              selected.add(list[index]);
            });
          } else {
            setState(() {
              selected.remove(list[index]);
            });
          }
          setState(() {
            selection[index] = !selection[index];
          });
        }
        print('Selection--->$selection');
        print('list-->>$selected');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: selection[index] ? radioColor : Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Container(
            height: 40,
            width: SizeConfig.screenWidthPercentage(percentage: 50),
            decoration: BoxDecoration(
              color: selection[index] ? radioColor : Colors.white,
            ),
            child: Center(
                child: Text(
              text,
              style: TextStyle(
                  color: selection[index] ? Colors.white : Colors.black),
            )),
          )
        ],
      ),
    );
  }
}
