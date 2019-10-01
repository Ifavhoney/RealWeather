import 'package:flutter/material.dart';
import 'package:weather/screens/changeCity.dart';
import 'package:weather/screens/weather.dart';
import 'package:weather/screens/forecast.dart';
import 'package:weather/screens/home.dart';
import 'package:weather/data/data.dart' as data;

//TO DO - TURN APP INTO A STATE MANAGEMENT APP

void main() async {
  runApp(MaterialApp(
    title: "Weather",
    debugShowCheckedModeBanner: false,
    home: Home(),
    //No Need for theme data
    initialRoute: '/',
    routes: {
      '/weather': (context) => Weather(),
      '/forecast': (context) => Forecast(),
      '/changeCity': (context) => ChangeCity(),
    },
  ));
}
