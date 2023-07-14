import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/views/SignUpModule/pregnant_question_view.dart';
import 'package:page_transition/page_transition.dart';

class DisclaimerView extends StatefulWidget {
  const DisclaimerView({Key? key}) : super(key: key);

  @override
  _DisclaimerViewState createState() => _DisclaimerViewState();
}

class _DisclaimerViewState extends State<DisclaimerView> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: appBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: myContainer(
                    height: 29.5,
                    text: LocaleKeys.I_provide_you.tr(),
                    showButton: false),
              ),
              myButton(
                clicked: clicked,
                buttonText: LocaleKeys.Button_got_it_button.tr(),
                buttonColor: radioColor,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    clicked = !clicked;
                  });
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const PregnantQuestionView(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
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
