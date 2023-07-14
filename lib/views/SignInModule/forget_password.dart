import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ovulu/controllers/sign_in_controller.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/helping_method.dart';
import 'package:ovulu/views/SignInModule/confirm_password.dart';
import 'package:page_transition/page_transition.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool clicked = false;
  bool emailClicked = false, validEmail = false, busy = false;
  String email = '';
  final con = Get.find<SignInController>();

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
                  : SizeConfig.screenHeight * 1.5,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: appBackgroundColor,
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(appLogo),
                      height: SizeConfig.screenHeightPercentage(percentage: 35),
                      width: SizeConfig.screenWidthPercentage(percentage: 35),
                    ),
                    Text(
                      LocaleKeys.reset_email_msg.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizeConfig.verticalSpaceMedium,
                    myTextField(
                        onTap: () {
                          setState(() {
                            emailClicked = true;
                          });
                        },
                        onChanged: (value) {
                          if (EmailValidator.validate(value)) {
                            setState(() {
                              validEmail = true;
                              email = value;
                            });
                          } else {
                            setState(() {
                              validEmail = false;
                            });
                          }
                        },
                        obscurseText: false,
                        image: messagePic,
                        text: emailClicked
                            ? ''
                            : LocaleKeys.enter_email_address.tr()),
                    SizeConfig.verticalSpaceRegular,
                    myButton(
                      buttonText: LocaleKeys.send_button.tr(),
                      textColor: textColor,
                      clicked: clicked,
                      onPressed: () async {
                        if (validEmail) {
                          if (await checkInternet()) {
                            setState(() {
                              busy = true;
                            });
                            final status =
                                await con.passwordReminder(email: email);
                            setState(() {
                              busy = false;
                              validEmail = false;
                              // email = '';
                            });
                            if (status != null) {
                              if (status != false) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: ConfirmPassword(email: email),
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 500),
                                  ),
                                );
                              } else {
                                setState(() {
                                  busy = false;
                                  validEmail = false;
                                  email = '';
                                });
                                alertBox(
                                    context: context,
                                    errorText: LocaleKeys
                                        .error_msg_email_not_found
                                        .tr());
                              }
                            } else {
                              alertBox(
                                  context: context,
                                  errorText: LocaleKeys
                                      .error_msg_email_not_found
                                      .tr());
                            }
                          } else {
                            alertBox(
                                context: context,
                                errorText:
                                    LocaleKeys.error_msg_no_internet.tr());
                          }
                        } else {
                          alertBox(
                              context: context,
                              errorText:
                                  LocaleKeys.error_msg_invalid_email_msg.tr());
                        }
                      },
                    ),
                    SizeConfig.verticalSpaceLarge,
                    Text(
                      LocaleKeys.reset_email_bottom_msg.tr(),
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
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
