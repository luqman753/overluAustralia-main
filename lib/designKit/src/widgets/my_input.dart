import 'package:flutter/material.dart';

import '../../designKit.dart';

Widget myInput(
    {required String leadingTitle,
    required String hintText,
    required String trailingTitle,
    void Function(String)? onChanged,
    void Function()? onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: SizeConfig.screenOrientation == Orientation.portrait
            ? SizeConfig.screenHeightPercentage(percentage: 4)
            : SizeConfig.screenHeightPercentage(percentage: 8),
        width: SizeConfig.screenOrientation == Orientation.portrait
            ? SizeConfig.screenWidthPercentage(percentage: 18)
            : SizeConfig.screenWidthPercentage(percentage: 12),
        decoration: BoxDecoration(
          color: radioColor,
        ),
        child: Center(
          child: Text(
            leadingTitle,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
      Container(
        height: SizeConfig.screenOrientation == Orientation.portrait
            ? SizeConfig.screenHeightPercentage(percentage: 4)
            : SizeConfig.screenHeightPercentage(percentage: 8),
        width: SizeConfig.screenOrientation == Orientation.portrait
            ? SizeConfig.screenWidthPercentage(percentage: 30)
            : SizeConfig.screenWidthPercentage(percentage: 25),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: TextField(
          onTap: onTap,
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: SizeConfig.screenOrientation == Orientation.portrait
                    ? 14
                    : 12),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: SizeConfig.screenOrientation == Orientation.portrait
            ? SizeConfig.screenHeightPercentage(percentage: 4)
            : SizeConfig.screenHeightPercentage(percentage: 8),
        width: SizeConfig.screenOrientation == Orientation.portrait
            ? SizeConfig.screenWidthPercentage(percentage: 12)
            : SizeConfig.screenWidthPercentage(percentage: 8),
        decoration: BoxDecoration(
          color: radioColor,
        ),
        child: Center(
          child: Text(
            trailingTitle,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    ],
  );
}
