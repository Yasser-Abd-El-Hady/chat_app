import 'package:flutter/material.dart';

class Screen {
  static late double _height;
  static late double _width;

  Screen(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
  }

  static double get screenHeight {
    return _height;
  }

  static double get screenWidth {
    return _width;
  }
}
