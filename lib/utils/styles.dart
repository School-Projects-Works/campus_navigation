import 'package:flutter/material.dart';

class Styles {
  final BuildContext context;
  Styles(this.context);
  TextStyle title(
          {Color? color,
          FontWeight? fontWeight,
         double fontSize = 30,
          String? fontFamily,
          FontStyle? style,
          double height = 1.5}) =>
      TextStyle(
          color: color ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.bold,
          fontFamily: fontFamily ?? 'OpenSans',
          fontStyle: style ?? FontStyle.normal,
          height: height,
          fontSize: fontSize);

  TextStyle subtitle(
          {Color? color,
          FontWeight? fontWeight,
          double fontSize = 20,
          String? fontFamily,
          FontStyle? style,
          double height = 1.5}) =>
      TextStyle(
          color: color ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: fontFamily ?? 'OpenSans',
          fontStyle: style ?? FontStyle.normal,
          height: height,
          fontSize: fontSize);

  TextStyle body(
          {Color? color,
          FontWeight? fontWeight,
          double fontSize = 16,
          String? fontFamily,
          FontStyle? style,
          double height = 1.5}) =>
      TextStyle(
          color: color ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: fontFamily ?? 'OpenSans',
          fontStyle: style ?? FontStyle.normal,
          height: height,
          fontSize: fontSize);
}
