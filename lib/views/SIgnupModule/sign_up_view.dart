import 'package:easy_localization/src/public_ext.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ovulu/designKit/src/widgets/my_bottom_row.dart';
import 'package:ovulu/network/api.dart';
import 'package:ovulu/translations/local_keys.g.dart';
import 'package:ovulu/views/SignInModule/sgn_in_view.dart';
import 'package:ovulu/views/SignUpModule/name_view.dart';
import 'package:page_transition/page_transition.dart';
import '../../designKit/designKit.dart';
import '../../helping_method.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool clicked = false;
  bool emailClicked = false,
      passwordClicked = false,
      validEmail = false,
      validPassword = false,
      busy = false;
  final con = Get.find<SignUpController>();
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
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      LocaleKeys.welcome_to_ovulu_signup.tr(),
                      style: kNormalTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // myButton(
                  //   buttonText: 'Pay',
                  //   buttonColor: textColor,
                  //   onPressed: () async {
                  //     var request = BraintreeDropInRequest(
                  //       clientToken: 'sandbox_pg3tnrzw_x8x6rqnpj2pn62q6',
                  //       tokenizationKey: 'sandbox_pg3tnrzw_x8x6rqnpj2pn62q6',
                  //       collectDeviceData: true,
                  //       paypalRequest: BraintreePayPalRequest(
                  //         amount: '10.00',
                  //         displayName: 'AfaqAhmad',
                  //         currencyCode: 'US',
                  //         billingAgreementDescription:
                  //             'I hereby agree that flutter_braintree is great.',
                  //       ),
                  //       cardEnabled: true,
                  //     );
                  //     print('pre-DONE${request.paypalRequest}');
                  //     BraintreeDropInResult? result =
                  //         await BraintreeDropIn.start(request);
                  //     print('DONE');
                  //     if (result != null) {
                  //       print(result.paymentMethodNonce.description);
                  //       print(result.paymentMethodNonce.nonce);
                  //       print(
                  //           'Payment ${result.paymentMethodNonce.description}');
                  //     } else {
                  //       print('Error');
                  //     }
                  //   },
                  // ),

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
                              con.email.value = value;
                              if (EmailValidator.validate(value)) {
                                setState(() {
                                  validEmail = true;
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
                              con.password.value = value;
                              if (value.trim().length > 5) {
                                setState(() {
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
                      ],
                    ),
                  ),
                  myButton(
                    buttonText: LocaleKeys.Button_next_button.tr(),
                    textColor: textColor,
                    clicked: clicked,
                    onPressed: () async {
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     child: const NameView(),
                      //     type: PageTransitionType.fade,
                      //     duration: const Duration(milliseconds: 500),
                      //   ),
                      // );
                      if (validEmail && validPassword) {
                        if (await checkInternet()) {
                          setState(() {
                            busy = true;
                          });
                          bool status = await con.signUpUser();
                          setState(() {
                            busy = false;
                          });
                          if (status != null) {
                            if (status) {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: const NameView(),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 500),
                                ),
                              );
                            } else {
                              alertBox(
                                  context: context,
                                  errorText: LocaleKeys
                                      .error_msg_already_sign_up_error_msg
                                      .tr());
                            }
                          } else {}
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
                        } else if (!validPassword) {
                          alertBox(
                              context: context,
                              errorText: LocaleKeys
                                  .error_msg_invalid_password_msg
                                  .tr());
                        } else {
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
                          child: const SignIn(),
                          type: PageTransitionType.leftToRight,
                          duration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    child: Text(
                      LocaleKeys.already_have_an_account.tr(),
                      style: kSmallTextStyle,
                    ),
                  ),
                  SizeConfig.verticalSpaceSmall,
                  Padding(
                    padding:
                        SizeConfig.screenOrientation == Orientation.portrait
                            ? EdgeInsets.only(
                                left: SizeConfig.screenWidthPercentage(
                                    percentage: 10),
                                right: SizeConfig.screenWidthPercentage(
                                    percentage: 10))
                            : EdgeInsets.only(
                                left: SizeConfig.screenWidthPercentage(
                                    percentage: 30),
                                right: SizeConfig.screenWidthPercentage(
                                    percentage: 30)),
                    child: myBottomRow(context: context),
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
