import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:weather/data/data.dart' as data;
import 'package:http/http.dart' as http;
import 'package:weather/ui/changeCity.dart';
import 'package:weather/screens/forecast.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
  final String prevCity;
  Weather(this.prevCity);
}

class _WeatherState extends State<Weather> {
//Prev city

  String city;
  String _minTemp;
  String _maxTemp;
  String _currTemp;
  String _main;
  String _description;

  //TextStyles

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
    this.city = widget.prevCity;
    //getValuesSF();
    //print(this.city);
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
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
              this.city == null
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
                child: this.city == null
                    ? apiWidget(data.defaultCity)
                    : apiWidget(this.city)),
          )
        ],
      ),
    );
  }

  //Future is used to for data that may or may not come
  //Type Map because JSON<String, dynamic>
  //Has to be async

  void testApi() async {
    Map<String, dynamic> test =
        await API.callWeatherAPI(data.appKey, data.defaultCity);
    //(test);
  }

/*
  void getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('stringValue');
    this.city = stringValue;
  }
  */

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
            _description =
                snapshot.data["weather"][0]["description"].toString();
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

  void toDays(BuildContext context) async {
    this.city = this.city == null ? data.defaultCity : this.city;

    MaterialPageRoute route =
        MaterialPageRoute(builder: (BuildContext context) {
      return Forecast(
        city: this.city,
        minTemp: _minTemp,
        maxTemp: _maxTemp,
        currTemp: _currTemp,
        main: _main,
        description: _description,
      );
    });

    await Navigator.of(context).push(route);
  }

  void changeScreens(BuildContext contexts) async {
    var route = MaterialPageRoute(builder: (BuildContext context) {
      return ChangeCity();
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

class API {
  static Future<Map<String, dynamic>> callWeatherAPI(
      String apiKey, String city) async {
    //https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=YOUR_API_KEY

    String endpoint =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey";

    //comes http package - http.response gets the entire package so we are able to call get
    http.Response response = await http.get(endpoint);
    return jsonDecode(response.body);
  }
}
