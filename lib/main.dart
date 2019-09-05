import 'package:flutter/material.dart';
import 'package:weather/ui/changeCity.dart';
import 'package:weather/ui/weather.dart';
import 'package:weather/screens/forecast.dart';
import 'package:weather/data/data.dart' as data;

//TO DO - TURN APP INTO A STATE MANAGEMENT APP

void main() async {
  runApp(MaterialApp(
    title: "Weather",
    debugShowCheckedModeBanner: false,
    home: Weather(data.defaultCity),
    initialRoute: '/',
    routes: {
      '/forecast': (context) => Forecast(),
      '/changeCity': (context) => ChangeCity(),
    },
  ));
}
