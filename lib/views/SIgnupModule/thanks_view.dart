import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ovulu/controllers/sign_up_controller.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/views/SignInModule/sgn_in_view.dart';
import 'package:ovulu/views/dashboard/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helping_method.dart';

class ThanksView extends StatefulWidget {
  const ThanksView({Key? key}) : super(key: key);

  @override
  _ThanksViewState createState() => _ThanksViewState();
}

class _ThanksViewState extends State<ThanksView> {
  bool clicked = false, busy = false;
  SharedPreferences? prefs;
  String? name;
  final con = Get.find<SignUpController>();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   SharedPreferences.getInstance().then((SharedPreferences sp) {
  //     prefs = sp;
  //     name = prefs!.getString('name');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      prefs = sp;
      name = prefs!.getString('name');
      setState(() {});
    });
    SizeConfig.initSize(context);
    double height = SizeConfig.screenHeight;
    double width = SizeConfig.screenWidth;
    // SizeConfig.screenOrientation == Orientation.portrait
    //     ? ScreenUtil.init(BoxConstraints(maxWidth: width, maxHeight: height),
    //         designSize: Size(width, height))
    //     : ScreenUtil.init(BoxConstraints(maxWidth: width, maxHeight: height),
    //         designSize: Size(width, height));
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: busy,
        progressIndicator: CircularProgressIndicator(
          color: appBackgroundColor,
        ),
        child: SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight,
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
                      height: 25,
                      text:
                          '${LocaleKeys.thanks_screen_text1.tr()}$name${LocaleKeys.thanks_screen_text2.tr()}',
                      showButton: false),
                ),
                myButton(
                  clicked: clicked,
                  buttonText: LocaleKeys.Button_lets_go_button.tr(),
                  onPressed: () async {
                    setState(() {
                      clicked = !clicked;
                    });
                    if (await checkInternet()) {
                      setState(() {
                        busy = true;
                      });
                      bool status = await con.updateData();
                      if (status) {
                        alertBox(
                            context: context,
                            errorText: LocaleKeys.thanks_msg.tr(),
                            showOps: false);
                        Timer(const Duration(seconds: 2), () {
                          Get.offAll(() => const DashBoard(),
                              transition: Transition.fade);
                        });
                      } else {
                        alertBox(context: context, errorText: 'Issue');
                      }
                      setState(() {
                        busy = false;
                      });
                    } else {
                      alertBox(
                          context: context,
                          errorText: LocaleKeys.error_msg_no_internet.tr());
                    }
                  },
                ),
                myBottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
