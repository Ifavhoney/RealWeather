/*

import 'package:flutter/material.dart';

Widget apiWidget(String _city) {
  //Have to return soemthing
  return FutureBuilder(
    //future builder requires a Future<Map>
    future: API.callWeatherAPI(data.appKey, _city),
    builder:
        (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
      //check if there is data
      try {
        if (snapshot.hasData) {
          _currTemp = snapshot.data["main"]["temp"].toString() + "˚C";
          _minTemp = snapshot.data["main"]["temp_min"].toString() + "˚C";
          _maxTemp = snapshot.data["main"]["temp_max"].toString() + "˚C";
          _main = snapshot.data["weather"][0]["main"].toString();
          _description = snapshot.data["weather"][0]["description"].toString();
          // print(_description);
          return Container(
            // alignment: Alignment.bottomRight,
            child: ListTile(
              //reading json
              title: snapshot.data["main"]["temp"].toString() == null
                  ? Text("Invalid City")
                  : Text("Actual Temp: " + _currTemp, style: tempStyle),
              subtitle: Text(
                "Min Temp: " + _minTemp + "\nMax Temp: " + _maxTemp,
                style: trailingTempStyle,
              ),
            ),
          );
        } else {
          return Container();
        }
      } catch (exception) {
        print(exception);

        return Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Invalid City",
              style: errorStyle,
            ));
      }
    },
  );
}
*/
