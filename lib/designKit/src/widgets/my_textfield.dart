import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ovulu/designKit/src/uiHelpers/size_config.dart';

import '../../designKit.dart';

Widget myTextField({
  required String image,
  required String text,
  required bool obscurseText,
  required void Function() onTap,
  required void Function(String)? onChanged,
}) {
  return Container(
    padding: EdgeInsets.all(0),
    height: SizeConfig.screenOrientation == Orientation.portrait
        ? SizeConfig.screenHeightPercentage(percentage: 6.5)
        : SizeConfig.screenHeightPercentage(percentage: 15),
    width: SizeConfig.screenOrientation == Orientation.portrait
        ? SizeConfig.screenWidthPercentage(percentage: 70)
        : SizeConfig.screenWidthPercentage(percentage: 50),
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            image,
            height: SizeConfig.screenHeightPercentage(percentage: 10),
            width: SizeConfig.screenWidthPercentage(percentage: 10),
          ),
        ),
        // ignore: prefer_const_constructors
        Expanded(
          child: TextField(
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
            onTap: onTap,
            onChanged: onChanged,
            obscureText: obscurseText,
            // keyboardType: keyBoardType,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                hintText: text,
                // hintStyle: TextStyle(fontWeight: FontWeight.bold),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
          ),
        )
      ],
    ),
  );
}
