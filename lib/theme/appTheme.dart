import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
    errorColor: Colors.pink,
    appBarTheme: AppBarTheme(
      color: Colors.lightBlue,
    ));

class GlobalTextStyle {
  static final TextStyle cityStyle =
      TextStyle(color: Colors.pink, fontSize: 40, fontWeight: FontWeight.w700);

  static TextStyle trailingTempStyle = TextStyle(
      color: Colors.pink.shade200, fontSize: 10, fontWeight: FontWeight.bold);

  static final TextStyle tempStyle = TextStyle(
      color: Colors.redAccent.shade700,
      fontSize: 15,
      fontWeight: FontWeight.bold);

  static final TextStyle errorStyle =
      TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold);
}
