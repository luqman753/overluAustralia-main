import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ovulu/controllers/sign_in_controller.dart';
import 'package:ovulu/designKit/src/uiHelpers/size_config.dart';
import 'package:ovulu/models/user_model.dart';
import 'package:ovulu/views/SIgnupModule/sign_up_view.dart';
import 'package:ovulu/views/SignInModule/sgn_in_view.dart';
import 'package:ovulu/views/dashboard/dashboard.dart';
import 'package:page_transition/page_transition.dart';
import '../../designKit/designKit.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer(const Duration(seconds: 3), () {
    //   Navigator.pushReplacement(
    //     context,
    //     PageTransition(
    //       child: const SignUpView(),
    //       type: PageTransitionType.fade,
    //       duration: const Duration(milliseconds: 500),
    //     ),
    //   );
    // });
  }

  final con = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    return FutureBuilder(
      future: Future.wait(
        [
          con.syncUser(),
          Future.delayed(const Duration(seconds: 1)),
        ],
      ),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            print(snapshot.data![0]);
            if (snapshot.data![0]) {
              print(snapshot.data);
              final user = snapshot.data;
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                Get.off(() => const DashBoard(), transition: Transition.fade);
              });
            } else {
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                Get.off(() => const SignUpView(), transition: Transition.fade);
              });
            }
          }
        }
        return Scaffold(
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              color: appBackgroundColor,
              image: DecorationImage(
                image: AssetImage(appLogo),
              ),
            ),
          ),
        );
      },
    );
  }
}
