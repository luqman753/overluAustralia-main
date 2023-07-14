import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';

Widget container(
    {required Widget child, required double height, double width = 100}) {
  return Container(
    height: SizeConfig.screenOrientation == Orientation.portrait
        ? SizeConfig.screenHeightPercentage(percentage: height)
        : SizeConfig.screenHeightPercentage(percentage: (height + 5)),
    width: SizeConfig.screenOrientation == Orientation.portrait
        ? SizeConfig.screenWidthPercentage(percentage: width)
        : SizeConfig.screenWidthPercentage(percentage: width - 30),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: containerBackgroundColor,
    ),
    child: Padding(
      padding: SizeConfig.screenOrientation == Orientation.portrait
          ? const EdgeInsets.all(30.0)
          : const EdgeInsets.all(20.0),
      child: child,
    ),
  );
}

Widget myContainer(
    {required String text,
    required bool showButton,
    void Function(String)? onChanged,
    double height = 30,
    bool validate = true,
    String? hintText,
    void Function()? onTap}) {
  return container(
    height: height,
    child: Column(
      mainAxisAlignment: showButton
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(wordSpacing: 3.0, fontSize: 18, color: textColor),
          textAlign: TextAlign.center,
        ),
        showButton
            ? Container(
                // width: SizeConfig.screenWidthPercentage(percentage: 60),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidthPercentage(percentage: 5),
                  ),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    maxLength: 26,
                    onTap: onTap,
                    onChanged: onChanged,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        // errorText: validate ? '' : 'Enter corrent name',
                        counterText: '',
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        errorStyle: TextStyle(package: 'yes'),
                        // focusColor: Colors.transparent,
                        focusedBorder: InputBorder.none,
                        hintText: hintText),
                  ),
                ),
              )
            : Text(''),
      ],
    ),
  );
}
