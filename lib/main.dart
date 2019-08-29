import 'package:flutter/material.dart';
import 'package:weather/ui/weather.dart';

void main() async {
  runApp(MaterialApp(
    title: "Weather",
    debugShowCheckedModeBanner: false,
    home: Weather(),
  ));
}
