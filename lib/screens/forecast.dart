import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/data.dart' as data;
import 'package:weather/screens/weather.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';
import 'package:weather/widgets/footer/footer.dart';
import 'package:weather/widgets/forecast/allIcons.dart';

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

  TextStyle styleTime =
      TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);
  TextStyle styleDays =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);

  Image _image = null;
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
                child:
                    bodyWidget(_sharedCity == null ? widget.city : _sharedCity))
          ],
        ));
  }

  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('stringValue');

    _sharedCity = stringValue;
  }

//Shows the the header

  Widget headerWidget(String _city) {
    return FutureBuilder(
      future: data.WeatherAPIs.callTodayWeather(data.appKey, _city),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          String _temp = snapshot.data["main"]["temp"].toString() + "˚C";
          String _minTemp = snapshot.data["main"]["temp_min"].toString() + "˚C";
          //   print(_minTemp);

          String _maxTemp = snapshot.data["main"]["temp_max"].toString() + "˚C";
          String _main = snapshot.data["weather"][0]["main"].toString();
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
            leading: AllIcons.showMain(widget.main, 10),

            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _temp,
                  style: styleTime,
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
                      tempCard(
                        type: "max",
                        temp: _maxTemp,
                      ),
                      tempCard(
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

  Widget bodyWidget(String _city) {
    return FutureBuilder(
        future: callAPI(data.bodyKey, _city),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                headerWidget(_city),
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

                      String _currMain = snapshot.data["list"][i]["weather"][0]
                              ["main"]
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
                                          style: styleTime,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                        ),
                                        AllIcons.showMain(widget.main, 50)
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          _currDate,
                                          style: styleDays,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                        ),
                                        Text(
                                          _currDesc,
                                          style: styleDays,
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
                                    style: styleCurrTemp,
                                  ),
                                  Text(
                                    "----------",
                                    style: styleCurrTemp,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        _currHumidity,
                                        style: styleCurrTemp,
                                      ),
                                      Text("\n humidity",
                                          style: styleCurrHumidity)
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

            /*
            return ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(snapshot.data["list"][i]["dt_txt"].toString()),
                      Text("Temp: " +
                          snapshot.data["list"][i]["main"]["temp"].toString() +
                          "˚C"),
                      Text("Min Temp:  " +
                          snapshot.data["list"][i]["main"]["temp_min"]
                              .toString() +
                          "˚C"),
                      Text("Max Temp:  " +
                          snapshot.data["list"][i]["main"]["temp_max"]
                              .toString() +
                          "˚C"),
                      Text("Sea Level: " +
                          snapshot.data["list"][i]["main"]["sea_level"]
                              .toString()),
                      Text("ground Level: " +
                          snapshot.data["list"][i]["main"]["grnd_level"]
                              .toString()),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  );
                }
              },
            );
            */
          } else {
            return Container(
              child: Text("empty"),
            );
          }
        });
  }

  Future<Map<String, dynamic>> callAPI(String apiKey, String city) async {
    String endpoint =
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric";

    //comes http package - http.response gets the entire package so we are able to call get
    http.Response response = await http.get(endpoint);
    return jsonDecode(response.body);
  }

  void testAPI() async {
    Map<String, dynamic> test = await callAPI(data.appKey, data.defaultCity);
    print(test);
  }
}

class tempCard extends StatelessWidget {
  final String temp;
  final String type;

  const tempCard({this.type, this.temp});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Color.fromARGB(255, 0, 255, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(1, 0, 0, 1),
          child: Text(" $type: " + temp + " "),
        ),
      ),
    );
  }
}
