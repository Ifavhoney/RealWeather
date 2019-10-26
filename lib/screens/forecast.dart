import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weather/widgets/footer/footer.dart';

import 'package:weather/widgets/forecast/body.dart';

class Forecast extends StatefulWidget {
  final String city;
  final String minTemp;
  final String maxTemp;
  final String currTemp;
  final String main;
  final String description;
  Forecast(
      {Key key,
      this.city,
      this.minTemp,
      this.maxTemp,
      this.currTemp,
      this.main,
      this.description})
      : super(key: key);

  @override
  _DaysState createState() => _DaysState();
}

class _DaysState extends State<Forecast> {
  TextStyle styleTemp =
      TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold);

  TextStyle styleCurrTemp =
      TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold);

  TextStyle styleCurrHumidity =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);

  TextStyle styleDays =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle styleTime =
      TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);

  String _sharedCity;
  int _currentIndex = 1;

//Does something upon scrolling down
  ScrollController controller;

/*
@override
void initState() { 
  super.initState();
  controller = ScrollController().addListener(listener);
  
}
@override
void dispose() { 
  //called when an object is disposed from the tree
  controller = ScrollController().removeListener(listener)
  super.dispose();
}
*/
  Widget build(BuildContext context) {
    getValuesSF();
    return Scaffold(
        bottomNavigationBar: Footer(
            currentIndex: _currentIndex,
            city: _sharedCity == null ? widget.city : _sharedCity),
        body: Stack(
          children: <Widget>[
            Positioned(
              child: Image.asset(
                "images/wallpaper.jpg",
                fit: BoxFit.fill,
                height: 2000,
                width: 3000,
              ),
            ),
            Container(
                height: 5000,
                width: 2000,
                child: Body(_sharedCity == null ? widget.city : _sharedCity,
                    widget.main))
          ],
        ));
  }

  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('stringValue');

    _sharedCity = stringValue;
  }
}
