import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ovulu/controllers/sign_in_controller.dart';
import 'package:ovulu/designKit/designKit.dart';
import 'package:ovulu/helping_method.dart';
import 'package:ovulu/views/SIgnupModule/name_view.dart';
import 'package:ovulu/views/SIgnupModule/sign_up_view.dart';
import 'package:ovulu/views/dashboard/dashboard.dart';
import 'package:page_transition/page_transition.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool clicked = false;
  bool emailClicked = false,
      passwordClicked = false,
      validEmail = false,
      validPassword = false,
      busy = false;
  final con = Get.find<SignInController>();
  String email = '', password = '';
  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: ModalProgressHUD(
          inAsyncCall: busy,
          progressIndicator: CircularProgressIndicator(
            color: appBackgroundColor,
          ),
          child: SingleChildScrollView(
            // physics: SizeConfig.screenOrientation == Orientation.portrait
            //     ? NeverScrollableScrollPhysics()
            //     : AlwaysScrollableScrollPhysics(),
            child: Container(
              height: SizeConfig.screenOrientation == Orientation.portrait
                  ? SizeConfig.screenHeight
                  : SizeConfig.screenHeight * 1.5,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: appBackgroundColor,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(appLogo),
                    height: SizeConfig.screenHeightPercentage(percentage: 35),
                    width: SizeConfig.screenWidthPercentage(percentage: 35),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60, right: 60),
                    child: Text(
                      LocaleKeys.welcome_to_ovulu_signin.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.verticalSpaceTiny,
                  Container(
                    height: SizeConfig.screenOrientation == Orientation.portrait
                        ? SizeConfig.screenHeightPercentage(percentage: 25)
                        : SizeConfig.screenHeightPercentage(percentage: 40),
                    width: SizeConfig.screenWidthPercentage(percentage: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        myTextField(
                            onTap: () {
                              setState(() {
                                emailClicked = true;
                                passwordClicked = false;
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
                        myTextField(
                            onTap: () {
                              setState(() {
                                emailClicked = false;
                                passwordClicked = true;
                              });
                            },
                            onChanged: (value) {
                              if (value.trim().length > 5) {
                                setState(() {
                                  validPassword = true;
                                  password = value;
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
                                : LocaleKeys.enter_password.tr())
                      ],
                    ),
                  ),
                  myButton(
                    buttonText: LocaleKeys.Button_next_button.tr(),
                    textColor: textColor,
                    clicked: clicked,
                    onPressed: () async {
                      if (validEmail /*&& validPassword*/) {
                        if (await checkInternet()) {
                          con.email = email;
                          con.password = password;
                          setState(() {
                            busy = true;
                          });
                          final status = await con.signInUser();
                          setState(() {
                            busy = false;
                          });
                          if (status != null) {
                            if (status != false) {
                              Get.offAll(() =>   DashBoard(),
                              // NameView(),
                             
                                  transition: Transition.downToUp);
                            } else {
                              alertBox(
                                  context: context,
                                  errorText: LocaleKeys
                                      .error_msg_login_error_msg
                                      .tr());
                            }
                          } else {
                            alertBox(
                                context: context,
                                errorText:
                                    LocaleKeys.error_msg_available_email.tr());
                          }
                        } else {
                          alertBox(
                              context: context,
                              errorText: LocaleKeys.error_msg_no_internet.tr());
                        }
                      } else {
                        if (!validEmail) {
                          alertBox(
                              context: context,
                              errorText:
                                  LocaleKeys.error_msg_invalid_email_msg.tr());
                        }
                        // else if (!validPassword) {
                        //   alertBox(
                        //       context: context,
                        //       errorText: LocaleKeys
                        //           .error_msg_invalid_password_msg
                        //           .tr());
                        // }
                        else {
                          alertBox(
                              context: context,
                              errorText: LocaleKeys
                                  .error_msg_enter_email_and_password_msg
                                  .tr());
                        }
                      }
                    },
                  ),
                  SizeConfig.verticalSpaceMedium,
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const SignUpView(),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    child: Text(
                      LocaleKeys.dont_have_account.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizeConfig.verticalSpaceSmall,
                  Padding(
                    padding:
                        SizeConfig.screenOrientation == Orientation.portrait
                            ? EdgeInsets.only(
                                bottom: SizeConfig.screenHeightPercentage(
                                    percentage: 3),
                                left: SizeConfig.screenWidthPercentage(
                                    percentage: 10),
                                right: SizeConfig.screenWidthPercentage(
                                  percentage: 10,
                                ))
                            : EdgeInsets.only(
                                left: SizeConfig.screenWidthPercentage(
                                    percentage: 30),
                                right: SizeConfig.screenWidthPercentage(
                                    percentage: 30)),
                    child: myBottomRow(context: context, forgetPassword: true),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
