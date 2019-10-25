import 'package:flutter/material.dart';
import 'package:weather/theme/appTheme.dart';

//Refers to ApiWidget from Weather.dart
class ApiWidget extends StatelessWidget {
  //Neccessary fields
  final String city;
  final bool hasData;
  final String minTemp;
  final String maxTemp;
  final String currTemp;
  final String main;
  final String description;

  //Optional Named Parameters
  const ApiWidget(
      {@required this.hasData,
      @required this.city,
      this.minTemp,
      this.maxTemp,
      this.currTemp,
      this.main,
      this.description});

  @override
  Widget build(BuildContext context) {
    return this.hasData == true
        ? apiWidget(this.city, context)
        : apiWidget("N/A", context);
  }

  Widget apiWidget(String _city, BuildContext context) {
    if (this.hasData == true) {
      //Have to return soemthing
      // print(_description);

      return Container(
        // alignment: Alignment.bottomRight,
        child: ListTile(
          //reading json
          title: Text("Actual Temp: ", style: GlobalTextStyle.tempStyle),
          subtitle: Text(
            "Min Temp: " + minTemp + "\nMax Temp: " + maxTemp,
            style: GlobalTextStyle.trailingTempStyle,
          ),
        ),
      );
    } else {
      return Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Invalid City",
            style: GlobalTextStyle.errorStyle,
          ));
    }
  }
  //else {}
}
