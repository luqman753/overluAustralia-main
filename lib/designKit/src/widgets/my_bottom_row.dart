import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ovulu/views/SignInModule/forget_password.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../designKit.dart';

Widget myBottomRow(
    {required BuildContext context,
    bool forgetPassword = false,
    bool signIn = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () async {
          const url = "https://ovulu.thedatabase.net/Terms.pdf";
          if (await canLaunch(url))
            await launch(url);
          else
            // can't launch url, there is some error
            throw "Could not launch $url";
        },
        child: Text(
          LocaleKeys.terms_and_privacy.tr(),
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 18,
              color: Colors.white),
        ),
      ),
      forgetPassword
          ? GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const ForgetPassword(),
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Text(
                LocaleKeys.forget_pasword.tr(),
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                    color: Colors.white),
              ),
            )
          : GestureDetector(
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Subscription restored",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: appBackgroundColor,
                    textColor: textColor,
                    fontSize: 16.0);
              },
              child: Text(
                LocaleKeys.restore_purchase.tr(),
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
    ],
  );
}
