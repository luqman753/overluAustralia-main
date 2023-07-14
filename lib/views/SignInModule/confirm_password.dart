import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ovulu/controllers/sign_in_controller.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/designKit/src/widgets/my_otp_field.dart';
import 'package:ovulu/views/SignInModule/sgn_in_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';

import '../../helping_method.dart';

// ignore: must_be_immutable
class ConfirmPassword extends StatefulWidget {
  String email;
  ConfirmPassword({Key? key, required this.email}) : super(key: key);

  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  bool clicked = false, busy = false;
  bool passwordClicked = false,
      validPassword = false,
      validOtp = false,
      otp = true;
  int tries = 3;
  String value1 = '', value2 = '', value3 = '', value4 = '', password = '';
  late FocusNode pin1FN;
  late FocusNode pin2FN;
  late FocusNode pin3FN;
  late FocusNode pin4FN;
  final pinStyle = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
  final con = Get.find<SignInController>();

  @override
  void initState() {
    super.initState();
    pin1FN = FocusNode();
    pin2FN = FocusNode();
    pin3FN = FocusNode();
    pin4FN = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin1FN.dispose();
    pin2FN.dispose();
    pin3FN.dispose();
    pin4FN.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  void previousField(String value, FocusNode focusNode) {
    if (value.length == 0) {
      focusNode.requestFocus();
    }
  }

  Future<void> checkOtp() async {
    if (value1 != '' && value2 != '' && value3 != '' && value4 != '') {
      if (await checkInternet()) {
        setState(() {
          busy = true;
        });
        con.otp = value1 + value2 + value3 + value4;
        final status = await con.checkOtp(email: widget.email, otp: con.otp);
        if (status != null) {
          if (status != false) {
            pin1FN.unfocus();
            setState(() {
              busy = false;
              validOtp = true;
              otp = true;
              value1 = '';
              value2 = '';
              value3 = '';
              value4 = '';
            });
          } else {
            setState(() {
              busy = false;
              validOtp = false;
              otp = false;
              tries -= 1;
              value1 = '';
              value2 = '';
              value3 = '';
              value4 = '';
            });
            if (tries == 0) {
              Navigator.pop(context);
            } else {
              alertBox(
                  context: context,
                  errorText: LocaleKeys.error_msg_otp_error_text1.tr() +
                      ' $tries ' +
                      LocaleKeys.error_msg_otp_error_text2.tr());
            }
          }
        } else {
          setState(() {
            busy = false;
            validOtp = false;
            otp = false;
            // tries -= 1;
            value1 = '';
            value2 = '';
            value3 = '';
            value4 = '';
          });
        }
      } else {
        alertBox(
            context: context, errorText: LocaleKeys.error_msg_no_internet.tr());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: busy,
          progressIndicator: CircularProgressIndicator(
            color: appBackgroundColor,
          ),
          child: SingleChildScrollView(
            child: Container(
              height: SizeConfig.screenOrientation == Orientation.portrait
                  ? SizeConfig.screenHeight
                  : SizeConfig.screenHeight * 1.3,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: appBackgroundColor,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: validOtp
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: validOtp
                          ? const EdgeInsets.only(bottom: 50)
                          : const EdgeInsets.all(0.0),
                      child: Image(
                        image: AssetImage(appLogo),
                        height:
                            SizeConfig.screenHeightPercentage(percentage: 35),
                        width: SizeConfig.screenWidthPercentage(percentage: 35),
                      ),
                    ),
                    validOtp
                        ? Container(
                            padding: EdgeInsets.only(bottom: 60),
                            height: SizeConfig.screenHeightPercentage(
                                percentage: 30),
                            width: SizeConfig.screenWidthPercentage(
                                percentage: 80),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  LocaleKeys.enter_new_password.tr(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    wordSpacing: 3,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                myTextField(
                                    onTap: () {
                                      setState(() {
                                        passwordClicked = true;
                                      });
                                    },
                                    onChanged: (value) {
                                      if (value.trim().length > 5) {
                                        setState(() {
                                          password = value;
                                          validPassword = true;
                                        });
                                      } else {
                                        setState(() {
                                          validPassword = false;
                                        });
                                      }
                                    },
                                    obscurseText: true,
                                    image: lockPic,
                                    text: passwordClicked
                                        ? ''
                                        : LocaleKeys.enter_password.tr()),
                                myButton(
                                  buttonText:
                                      LocaleKeys.Button_save_button.tr(),
                                  textColor: textColor,
                                  clicked: clicked,
                                  onPressed: () async {
                                    if (validPassword) {
                                      if (await checkInternet()) {
                                        setState(() {
                                          busy = true;
                                        });
                                        bool status = await con.changePassword(
                                            email: widget.email,
                                            otp: con.otp,
                                            newPassword: password);
                                        setState(() {
                                          busy = false;
                                        });
                                        if (status != null) {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              child: SignIn(),
                                              type: PageTransitionType.fade,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            ),
                                          );
                                        } else {}
                                      } else {
                                        alertBox(
                                            context: context,
                                            errorText: LocaleKeys
                                                .error_msg_no_internet
                                                .tr());
                                      }
                                    } else {
                                      alertBox(
                                          context: context,
                                          errorText: LocaleKeys
                                              .error_msg_invalid_password_msg
                                              .tr());
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        : Text(
                            LocaleKeys.new_password_screen.tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                    validOtp ? Text('') : SizeConfig.verticalSpaceLarge,
                    validOtp
                        ? Text('')
                        : Padding(
                            padding: EdgeInsets.only(
                                bottom: 150,
                                left: SizeConfig.screenWidthPercentage(
                                    percentage: 15),
                                right: SizeConfig.screenWidthPercentage(
                                    percentage: 15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                myOtpField(
                                  right: otp,
                                  onChanged: (value) async {
                                    setState(() {
                                      value1 = value;
                                    });
                                    await checkOtp();
                                    if (value.length == 1) {
                                      nextField(value, pin2FN);
                                    } else {
                                      pin1FN.unfocus();
                                    }
                                  },
                                  autofocus: true,
                                  focusNode: pin1FN,
                                ),
                                myOtpField(
                                    right: otp,
                                    onChanged: (value) async {
                                      setState(() {
                                        value2 = value;
                                      });
                                      await checkOtp();
                                      if (value.length == 1) {
                                        nextField(value, pin3FN);
                                      } else {
                                        pin2FN.unfocus();
                                        previousField(value, pin1FN);
                                      }
                                    },
                                    focusNode: pin2FN),
                                myOtpField(
                                    right: otp,
                                    onChanged: (value) async {
                                      setState(() {
                                        value3 = value;
                                      });
                                      await checkOtp();
                                      if (value.length == 1) {
                                        nextField(value, pin4FN);
                                      } else {
                                        pin3FN.unfocus();
                                        previousField(value, pin2FN);
                                      }
                                    },
                                    focusNode: pin3FN),
                                myOtpField(
                                    right: otp,
                                    onChanged: (value) async {
                                      setState(() {
                                        value4 = value;
                                      });
                                      await checkOtp();
                                      if (value.length == 1) {
                                        pin4FN.unfocus();
                                      } else {
                                        pin4FN.unfocus();
                                        previousField(value, pin3FN);
                                      }
                                    },
                                    focusNode: pin4FN),
                              ],
                            ),
                          ),
                    // validOtp ? Text('') : SizeConfig.verticalSpaceMedium,
                    // validOtp
                    //     ?
                    //     : Text(''),
                    // SizeConfig.verticalSpaceTiny,
                    validOtp ? SizeConfig.verticalSpaceLarge : const Text(''),
                    GestureDetector(
                        onTap: () => Get.offAll(() => SignIn()),
                        child: Padding(
                          padding: validOtp
                              ? const EdgeInsets.all(0.0)
                              : EdgeInsets.only(bottom: 100),
                          child: Text(
                            LocaleKeys.go_back.tr(),
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
