import 'package:flutter/material.dart';
import 'package:weather/ui/changeCity.dart';
import 'package:weather/ui/weather.dart';
import 'package:weather/screens/forecast.dart';

//TO DO - TURN APP INTO A STATE MANAGEMENT APP

void main() async {
  runApp(MaterialApp(
    title: "Weather",
    debugShowCheckedModeBanner: false,
    home: Weather(),
    initialRoute: '/',
    routes: {
      '/forecast': (context) => Forecast(),
      '/changeCity': (context) => ChangeCity(),
    },
  ));
}
