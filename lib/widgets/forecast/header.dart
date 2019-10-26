import 'package:flutter/material.dart';
import 'package:weather/widgets/forecast/allIcons.dart';
import 'package:weather/data/data.dart' as data;
import 'package:weather/widgets/forecast/tempCard.dart';

class Header extends StatelessWidget {
  static TextStyle _styleTime =
      TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);
  final String main;
  final String city;
  Header({this.main, this.city});
  @override
  Widget build(BuildContext context) {
    return headerWidget(this.city);
  }

//Shows the the header
  Widget headerWidget(String _city) {
    return FutureBuilder(
      future: data.WeatherAPIs.callTodayAPI(data.appKey, _city),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          String _temp = snapshot.data["main"]["temp"].toString() + "˚C";
          String _minTemp = snapshot.data["main"]["temp_min"].toString() + "˚C";
          //   print(_minTemp);

          String _maxTemp = snapshot.data["main"]["temp_max"].toString() + "˚C";
          String _description =
              snapshot.data["weather"][0]["description"].toString();
          return SliverAppBar(
            //how far AppBar expands
            expandedHeight: 70,
            floating: true,
            backgroundColor: Colors.lightBlue,
            //pins appbar to top,
            //    pinned: true,
            // title: Text("Sliver AppBar"),
            ///flexbible space bar
            leading: AllIcons.showMain(this.main, 10),

            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _temp,
                  style: _styleTime,
                ),
                Text(
                  _description,
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            actions: [
              Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TempCard(
                        type: "max",
                        temp: _maxTemp,
                      ),
                      TempCard(
                        type: "min",
                        temp: _minTemp,
                      )
                    ],
                  )
                ],
              ),
            ],
          );
        } else {
          return SliverAppBar(
            expandedHeight: 70,
            floating: true,
            title: Text(" "),
          );
        }
      },
    );
  }
}
