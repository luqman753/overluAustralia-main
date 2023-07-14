import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/translations/local_keys.g.dart';
import 'package:ovulu/views/SignUpModule/question_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameView extends StatefulWidget {
  const NameView({Key? key}) : super(key: key);

  @override
  State<NameView> createState() => _NameViewState();
}

class _NameViewState extends State<NameView> {
  String name = '';

  bool clicked = false, validateName = false, nameClicked = false;
  final con = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    height: SizeConfig.screenOrientation == Orientation.portrait
                        ? 30
                        : 40,
                    text: LocaleKeys.hi_my_name_is_jon.tr(),
                    showButton: true,
                    // validate: validateName,
                    onTap: () {
                      setState(() {
                        nameClicked = true;
                      });
                    },
                    hintText:
                        nameClicked ? '' : LocaleKeys.enter_your_name.tr(),
                    onChanged: (value) {
                      if (value.trim().length > 0) {
                        validateName = true;
                      } else {
                        validateName = false;
                      }
                      name = value;
                      setState(() {});
                    }),
              ),
              myButton(
                clicked: clicked,
                buttonText: 'Next',
                textColor: textColor,
                onPressed: () async {
                  if (validateName) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    String n = name[0].toUpperCase() + name.substring(1);
                    print(n);
                    con.name.value = n;
                    prefs.setString('name', n);
                    setState(() {
                      clicked = !clicked;
                    });
                    Get.to(() => QuestionView(name: n),
                        transition: Transition.fade);
                  } else {
                    alertBox(
                        context: context,
                        errorText: LocaleKeys.enter_name_error_msg.tr());
                  }
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
