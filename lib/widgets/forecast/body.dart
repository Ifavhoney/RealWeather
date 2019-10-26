import 'package:flutter/material.dart';
import 'package:weather/data/data.dart' as data;

import 'package:weather/widgets/forecast/allIcons.dart';
import 'package:expandable/expandable.dart';

import 'package:intl/intl.dart';
import 'package:weather/widgets/forecast/header.dart';

class Body extends StatelessWidget {
  final String city;
  final String main;

  Body(this.city, this.main);

  static TextStyle _styleCurrTemp =
      TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle _styleCurrHumidity =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);

  static TextStyle _styleDays =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
  static TextStyle _styleTime =
      TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return bodyWidget(this.city);
  }

  Widget bodyWidget(String _city) {
    return FutureBuilder(
        future: data.WeatherAPIs.callForecastAPI(data.bodyKey, _city),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                Header(
                  main: this.main,
                  city: _city,
                ),
                //List begins
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, i) {
                    if (i < 10) {
                      DateFormat f = new DateFormat('jm');
                      var _currTime = f.format(DateTime.parse(
                          snapshot.data["list"][i]["dt_txt"].toString()));

                      DateFormat f2 = new DateFormat('MMMEd');
                      var _currDate = f2.format(DateTime.parse(
                          snapshot.data["list"][i]["dt_txt"].toString()));

                      String _currDesc = snapshot.data["list"][i]["weather"][0]
                              ["description"]
                          .toString();

                      String _currTemp =
                          snapshot.data["list"][i]["main"]["temp"].toString();

                      String _currHumidity = snapshot.data["list"][i]["main"]
                              ["humidity"]
                          .toString();

                      return ExpandablePanel(
                        header: Stack(
                          children: <Widget>[
                            Container(
                                color: Colors
                                    .primaries[i % Colors.primaries.length]
                                    .withOpacity(0.5),
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          _currTime,
                                          style: _styleTime,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                        ),
                                        AllIcons.showMain(this.main, 50)
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          _currDate,
                                          style: _styleDays,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                        ),
                                        Text(
                                          _currDesc,
                                          style: _styleDays,
                                        )
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ),

                        //When clicking dropdown
                        expanded: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                                child: AllIcons.showDesc(_currDesc, context)),
                            Positioned(
                              //top: 100,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    _currTemp + "˚C",
                                    style: _styleCurrTemp,
                                  ),
                                  Text(
                                    "----------",
                                    style: _styleCurrTemp,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        _currHumidity,
                                        style: _styleCurrTemp,
                                      ),
                                      Text("\n humidity",
                                          style: _styleCurrHumidity)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        tapHeaderToExpand: true,
                        hasIcon: true,
                      );
                    }
                  }),
                )
              ],
            );
          } else {
            return Container(
              child: Text("empty"),
            );
          }
        });
  }
}
