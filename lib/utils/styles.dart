import 'package:flutter/material.dart';

class Styles {
  final BuildContext context;
  Styles(this.context);
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  bool get isMobile => width < 768;
  bool get isTablet => width >= 768 && width < 1100;
  bool get isDesktop => width >= 1100;

  bool get smallerThanTablet => width < 1100;
  bool get largerThanTablet => width >= 1100;
  bool get largerThanMobile => width >= 768;

  bool get isPortrait => height > width;
  bool get isLandscape => width > height;

  Widget rowColumnWidget(List<Widget> children,
          {bool isRow = true,
          MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
          MainAxisSize mainAxisSize = MainAxisSize.max,
          CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
          EdgeInsetsGeometry padding = EdgeInsets.zero}) =>
      isRow
          ? Row(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              children: children,
            )
          : Column(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              children: children,
            );

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
