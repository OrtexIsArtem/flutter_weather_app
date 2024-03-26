import 'package:flutter/material.dart';

/// context extension for ease of use
extension BuildContextExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
