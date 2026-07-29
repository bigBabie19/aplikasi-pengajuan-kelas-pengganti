import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  static const title = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static const body = TextStyle(
    fontSize: 15,
  );

  static const caption = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );
}