import 'package:flutter/material.dart';
import 'package:ovulu/designKit/designKit.dart';

const icon = Icon(
  Icons.arrow_drop_down,
  color: Color(0xff393737),
);
const TextStyle itemStyle = TextStyle(fontSize: 15, color: Colors.black);
const TextStyle style = TextStyle(color: Color(0xff393737), fontSize: 15);

Widget myFilter(
    {required BuildContext context,
    void Function(String?)? onChanged,
    Icon filterIcon = icon,
    TextStyle hintStyle = style,
    String hint = 'Please select',
    TextStyle itemDropDownStyle = itemStyle,
    Color dropDownColor = Colors.white,
    required Color backgroundColor,
    required List<String> listOfDropDownItem}) {
  return Container(
    color: backgroundColor,
    height: SizeConfig.screenOrientation == Orientation.portrait
        ? SizeConfig.screenHeightPercentage(percentage: 4)
        : SizeConfig.screenHeightPercentage(percentage: 8),
    width: SizeConfig.screenOrientation == Orientation.portrait
        ? SizeConfig.screenWidthPercentage(percentage: 42)
        : SizeConfig.screenWidthPercentage(percentage: 33),
    padding: EdgeInsets.only(left: 8),
    child: DropdownButton(
      isExpanded: true,
      dropdownColor: dropDownColor,
      underline: Text(''),
      hint: Center(
        child: Text(
          hint,
          maxLines: 1,
          softWrap: false,
          style: hintStyle,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
        ),
      ),
      // icon: filterIcon,
      style: itemDropDownStyle,
      items: listOfDropDownItem
          .map((val) => DropdownMenuItem<String>(
                value: val,
                child: Text(
                  val,
                ),
              ))
          .toList(),
      onChanged: onChanged,
    ),
  );
}
