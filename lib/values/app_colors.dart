import 'package:flutter/material.dart';

class AppColors {
  static List<Color> custom = [
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.lime,
    Colors.lightGreen,
    Colors.blue,
    Colors.purple,
  ];
}
gradientBG(int index) {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.75, 0), // 10% of the width, so there are ten blinds.
    colors: <Color>[
      AppColors.custom[index % 7].withOpacity(0.7),
      Colors.white
    ], // red to yellow
    tileMode: TileMode.repeated, // repeats the gradient over the canvas
  );
}
