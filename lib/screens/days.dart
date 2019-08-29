import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/data/data.dart' as data;
import 'package:shared_preferences/shared_preferences.dart';

class Days extends StatefulWidget {
  @override
  _DaysState createState() => _DaysState();
}

class _DaysState extends State<Days> {
  TextStyle styleDays = TextStyle(fontSize: 30, color: Colors.white);
  String _city;
  Widget build(BuildContext context) {
    getCity();
    return Scaffold(
        appBar: AppBar(
          title: Text("Days"),
        ),
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
            Container(height: 5000, width: 2000, child: apiWidget("toronto"))
          ],
        ));
  }

  void getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String city = (prefs.getString('city') ?? data.defaultCity);
    this._city = city;
    print(this._city);
  }

  Widget apiWidget(String _city) {
    return FutureBuilder(
        future: callAPI(data.appKey, _city),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
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
