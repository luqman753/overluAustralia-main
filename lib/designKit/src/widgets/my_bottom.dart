import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';

Widget myBottom({bool showGirl = true, bool showLogo = true}) {
  return Row(
    mainAxisAlignment:
        showGirl ? MainAxisAlignment.end : MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      showLogo
          ? Padding(
              padding: showGirl
                  ? EdgeInsets.only(
                      bottom: SizeConfig.screenHeightPercentage(percentage: 3),
                      right: 10,
                    )
                  : const EdgeInsets.all(0),
              child: Image.asset(
                appLogo,
                width: 50,
                height: 50,
              ),
            )
          : Text(''),
      showGirl
          ? Image.asset(
              girlPic,
              width: SizeConfig.screenOrientation == Orientation.portrait
                  ? 128
                  : 110,
              height: SizeConfig.screenOrientation == Orientation.portrait
                  ? 220
                  : 110,
              alignment: Alignment.bottomRight,
              fit: BoxFit.fill,
            )
          : Text(''),
    ],
  );
}
