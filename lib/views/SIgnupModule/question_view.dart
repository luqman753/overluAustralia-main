import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/translations/local_keys.g.dart';
import 'package:ovulu/views/SignUpModule/disclaimer_view.dart';
import 'package:page_transition/page_transition.dart';

class QuestionView extends StatefulWidget {
  String name;
  QuestionView({Key? key, required this.name}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  bool clicked = false;
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
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: myContainer(
                    height: 33,
                    text:
                        '${LocaleKeys.nice_to_meet_you_text1.tr()}${con.name}${LocaleKeys.nice_to_meet_you_text2.tr()}',
                    showButton: false),
              ),
              myButton(
                clicked: clicked,
                buttonText: LocaleKeys.Button_next_button.tr(),
                textColor: textColor,
                onPressed: () {
                  setState(() {
                    clicked = !clicked;
                  });
                  Get.to(() => const DisclaimerView(),
                      transition: Transition.fade);
                },
              ),
              myBottom(),
            ],
          ),
        ),
      ),
    );
  }
}
