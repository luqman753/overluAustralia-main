import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';

alertBox(
    {required BuildContext context,
    required String errorText,
    bool showOps = true}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: showOps
            ? Text(
                "Oops",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 25,
                ),
              )
            : Text(""),
        content: Text(
          errorText,
          style: TextStyle(color: Colors.grey, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Center(
              child: myButton(
                buttonText: 'OK',
                textColor: textColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}
