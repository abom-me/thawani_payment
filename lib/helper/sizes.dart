import 'package:flutter/material.dart';

class Sizes {
  Sizes._();

  /// Getting the full width of the screen
  static double width(context) {
    return MediaQuery.of(context).size.width;
  }

  /// Getting the full height of the screen

  static double height(context) {
    return MediaQuery.of(context).size.height;
  }
}

/// Class for different type of sized box
class BoxSize {
  static width(double num) {
    return SizedBox(
      width: num,
    );
  }

  static height(double num) {
    return SizedBox(
      height: num,
    );
  }

  static empty() {
    return const SizedBox.shrink();
  }
}
