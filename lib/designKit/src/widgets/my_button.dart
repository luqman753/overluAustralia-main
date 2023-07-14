import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';

Widget myButton({
  required String buttonText,
  void Function()? onPressed,
  Color buttonColor = Colors.white,
  Color textColor = Colors.black,
  bool clicked = false,
}) {
  return SizedBox(
    width: 110,
    child: TextButton(
        onPressed: onPressed,
        child: Text(buttonText,
            style: TextStyle(
                color:
                    clicked ? clickedButtonTextColor : unclickedButtonTextColor,
                fontSize: 20)),
        style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((state) => Colors.transparent),
            backgroundColor: MaterialStateColor.resolveWith((state) =>
                clicked ? clickedButtonColor : unclickedButtonColor))),
  );
}
