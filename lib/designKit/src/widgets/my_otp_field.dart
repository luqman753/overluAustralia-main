import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget myOtpField(
    {void Function(String)? onChanged,
    FocusNode? focusNode,
    bool autofocus = false,
    required bool right}) {
  return Container(
    height: 55,
    width: 45,
    decoration: BoxDecoration(
      color: Colors.white,
      border: right
          ? Border.all(color: Colors.white)
          : Border.all(color: Colors.red),
    ),
    child: Center(
      child: TextField(
        focusNode: focusNode,
        autofocus: autofocus,
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          counterText: '',
        ),
      ),
    ),
  );
}
