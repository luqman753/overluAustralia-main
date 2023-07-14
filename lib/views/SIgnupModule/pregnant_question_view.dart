import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/views/SignUpModule/comorbidities_view.dart';
import 'package:page_transition/page_transition.dart';

class PregnantQuestionView extends StatefulWidget {
  const PregnantQuestionView({Key? key}) : super(key: key);

  @override
  _PregnantQuestionViewState createState() => _PregnantQuestionViewState();
}

class _PregnantQuestionViewState extends State<PregnantQuestionView> {
  int selectedIndex = 3;
  bool clicked = false;
  List<String> list = [
    LocaleKeys.pregnant_options_option1.tr(),
    LocaleKeys.pregnant_options_option2.tr(),
    // 'I would rather not say'
  ];
  final con = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    double height = SizeConfig.screenHeight;
    double width = SizeConfig.screenWidth;
    // SizeConfig.screenOrientation == Orientation.portrait
    //     ? ScreenUtil.init(BoxConstraints(maxWidth: width, maxHeight: height),
    //         designSize: Size(width, height))
    //     : ScreenUtil.init(BoxConstraints(maxWidth: width, maxHeight: height),
            // designSize: Size(width, height));
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
              // SizeConfig.verticalSpaceLarge,
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.screenHeightPercentage(percentage: 15),
                  right: 40,
                  left: 40,
                ),
                child: Text(
                  LocaleKeys.pregnanat_or_not_screen.tr(),
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
                      ? 25
                      : 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      myRadio(text: list[0], index: 0),
                      myRadio(text: list[1], index: 1),
                      // myRadio(text: list[2], index: 2),
                      Divider(color: kBlackColor),
                      GestureDetector(
                          // print(con.pregnantOrNot.value);
                          onTap: () {
                            con.pregnantOrNot.value = '0';
                            Navigator.push(
                              context,
                              PageTransition(
                                child: const CoMorbiditiesView(),
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
              // SizeConfig.verticalSpaceSmall,
              myButton(
                clicked: clicked,
                buttonText: LocaleKeys.Button_next_button.tr(),
                textColor: textColor,
                onPressed: () {
                  if (selectedIndex == 0 || selectedIndex == 1) {
                    con.pregnantOrNot.value = (selectedIndex + 1).toString();
                    setState(() {
                      clicked = !clicked;
                    });
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const CoMorbiditiesView(),
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  } else {
                    alertBox(
                        context: context,
                        errorText: LocaleKeys
                            .error_msg_select_an_option_error_msg
                            .tr());
                  }
                },
              ),
              // SizeConfig.verticalSpaceLarge,
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
        setState(() {
          selectedIndex = index;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: selectedIndex == index ? radioColor : kWhiteColor,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Container(
            height: 35,
            width: SizeConfig.screenWidthPercentage(percentage: 50),
            decoration: BoxDecoration(
              color: selectedIndex == index ? radioColor : kWhiteColor,
            ),
            child: Center(
                child: Text(
              text,
              style: TextStyle(
                  color: selectedIndex == index ? kWhiteColor : kBlackColor),
            )),
          )
        ],
      ),
    );
  }
}
