import 'package:flutter/material.dart';

class SizeConfig {
  static late double _screenWidth;
  static late double _screenHeight;
  static late Orientation _orientation;

  static void initSize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _orientation = mediaQuery.orientation;
  }

  static get screenWidth => _screenWidth;

  static get screenHeight => _screenHeight;

  static get screenOrientation => _orientation;

  static double screenHeightPercentage({double percentage = 100}) =>
      _screenHeight * (percentage / 100);

  static double screenWidthPercentage({double percentage = 100}) =>
      _screenWidth * (percentage / 100);

  static SizedBox get horizontalSpaceTiny => SizedBox(
        width: screenHeightPercentage(percentage: 0.587),
      );
  static SizedBox get horizontalSpaceSmall => SizedBox(
        width: screenHeightPercentage(percentage: 1.175),
      );
  static SizedBox get horizontalSpaceRegular => SizedBox(
        width: screenHeightPercentage(percentage: 2.350),
      );
  static SizedBox get horizontalSpaceMedium => SizedBox(
        width: screenHeightPercentage(percentage: 4.700),
      );
  static SizedBox get horizontalSpaceLarge => SizedBox(
        width: screenHeightPercentage(percentage: 5.876),
      );

  static SizedBox get verticalSpaceTiny => SizedBox(
        height: screenHeightPercentage(percentage: 0.587),
      );
  static SizedBox get verticalSpaceSmall => SizedBox(
        height: screenHeightPercentage(percentage: 1.175),
      );
  static SizedBox get verticalSpaceRegular => SizedBox(
        height: screenHeightPercentage(percentage: 2.350),
      );
  static SizedBox get verticalSpaceMedium => SizedBox(
        height: screenHeightPercentage(percentage: 4.700),
      );
  static SizedBox get verticalSpaceLarge => SizedBox(
        height: screenHeightPercentage(percentage: 5.876),
      );
}
