import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/screens/changeCity.dart';
import 'package:weather/screens/weather.dart';
import 'package:weather/screens/forecast.dart';
import 'package:weather/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
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
      ),
    );
  }
}
