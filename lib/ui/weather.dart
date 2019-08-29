import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:weather/data/data.dart' as data;
import 'package:http/http.dart' as http;
import 'package:weather/ui/nextScreen.dart';
import 'package:weather/screens/days.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  //TextStyles
  String city;

  TextStyle cityStyle =
      TextStyle(color: Colors.pink, fontSize: 40, fontWeight: FontWeight.w700);

  TextStyle tempStyle = TextStyle(
      color: Colors.redAccent.shade700,
      fontSize: 15,
      fontWeight: FontWeight.bold);

  TextStyle trailingTempStyle = TextStyle(
      color: Colors.pink.shade200, fontSize: 10, fontWeight: FontWeight.bold);

  TextStyle errorStyle =
      TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    testApi();
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        backgroundColor: Colors.brown,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              //calls changeScreens
              changeScreens(this.context);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Image.asset(
              "images/EmilyJason.JPG",
              fit: BoxFit.fill,
              height: 3000,
              width: 2000,
            ),
          ),
          /*
          Positioned(
            child: Image.asset("images/light_rain.png"),
            top: 200,
            left: 40,
          ),
          */
          //padding: EdgeInsets.fromLTRB(100, 40, 0, 500),

          Container(
              child: Row(
            children: <Widget>[
              city == null
                  ? Text(
                      //Text = defaultCity, textStyle = citySyle
                      data.defaultCity,
                      style: cityStyle,
                    )
                  : Text(
                      city,
                      style: cityStyle,
                    ),
              IconButton(
                  icon: Icon(Icons.info), onPressed: () => toDays(context))
            ],
          )),
          Padding(
            padding: const EdgeInsets.fromLTRB(180, 0, 0, 0),
            child: Container(
              alignment: Alignment.bottomRight,
              child:
                  city == null ? apiWidget(data.defaultCity) : apiWidget(city),
            ),
          )
        ],
      ),
    );
  }

  //Future is used to for data that may or may not come
  //Type Map because JSON<String, dynamic>
  //Has to be async
  Future<Map<String, dynamic>> callAPI(String apiKey, String city) async {
    //https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=YOUR_API_KEY

    String endpoint =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey";

    //comes http package - http.response gets the entire package so we are able to call get
    http.Response response = await http.get(endpoint);
    return jsonDecode(response.body);
  }

  void testApi() async {
    Map<String, dynamic> test = await callAPI(data.appKey, data.defaultCity);
    //(test);
  }

  void getcity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', this.city);
    String city = (prefs.getString('city') ?? data.defaultCity);
    print(city);
  }

  Widget apiWidget(String _city) {
    //Have to return soemthing
    return FutureBuilder(
      //future builder requires a Future<Map>
      future: callAPI(data.appKey, _city),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        //check if there is data
        try {
          if (snapshot.hasData) {
            return Container(
              // alignment: Alignment.bottomRight,
              child: ListTile(
                //reading json
                title: snapshot.data["main"]["temp"].toString() == null
                    ? Text("Invalid City")
                    : Text(
                        "Actual Temp: " +
                            snapshot.data["main"]["temp"].toString() +
                            "˚C",
                        style: tempStyle),
                subtitle: Text(
                  "Min Temp: " +
                      snapshot.data["main"]["temp_min"].toString() +
                      "˚C" +
                      "\nMax Temp: " +
                      snapshot.data["main"]["temp_max"].toString() +
                      "˚C",
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

  void toDays(BuildContext context) async {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (BuildContext context) {
      return Days();
    });
    var results = await Navigator.of(context).push(route);

    try {
      if (results["value"] == null) {
        this.city = data.defaultCity;
      } else {
        //send this to next page
        this.city = results["value"];
      }
    } catch (exception) {
      print(exception);
    }
  }

  void changeScreens(BuildContext contexts) async {
    var route = MaterialPageRoute(builder: (BuildContext context) {
      return NextScreen();
    });

    //expecting a result - Navigator.of to push
    var results = await Navigator.of(contexts).push(route);

    try {
      //we are requesting "VALUE"
      if (results["value"] == null) {
        this.city = data.defaultCity;
      } else {
        //setting city to whatever value
        this.city = results["value"];
      }
    } catch (exception) {
      print(exception);
    }
  }
}

//we are changing state
//stateless = onpressed, text etc
