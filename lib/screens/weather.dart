import 'package:flutter/material.dart';
import 'package:weather/widgets/header/header.dart' as header;
import 'package:weather/widgets/weather/apiWidget.dart' as body;

import 'package:weather/data/data.dart' as data;
import 'package:weather/theme/appTheme.dart';
import 'package:weather/screens/changeCity.dart';
import 'package:weather/screens/forecast.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
  final String prevCity;

  Weather({this.prevCity});
}

class _WeatherState extends State<Weather> {
//Prev city

  String city;
  String _tempCity;
  String _minTemp;
  String _maxTemp;
  String _currTemp;
  String _main;
  String _description;

  //TextStyle

  @override
  Widget build(BuildContext context) {
    if (widget.prevCity == null && _tempCity == null) {
      this.city = data.defaultCity;
    } else if (_tempCity != null && widget.prevCity == null) {
      this.city = _tempCity;
    } else {
      this.city = widget.prevCity;
    }
    //getValuesSF();
    print(this.city);

    return Scaffold(
      appBar: header.BaseAppBar(
        leading: Container(),
        appBar: AppBar(),
        title: Text("Welcome!"),
        backgroundColor: Colors.lightBlue,
        widgets: <Widget>[
          IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () => changeScreens(this.context))
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Image.asset(
              //"images/EmilyJason.JPG"
              "images/mainWallpaper.jpg",
              fit: BoxFit.fill,
              height: 3000,
              width: 2000,
            ),
          ),
          Container(
              child: Row(
            children: <Widget>[
              this.city == null
                  ? Text(
                      //Text = defaultCity, textStyle = citySyle
                      data.defaultCity,
                      style: GlobalTextStyle.cityStyle,
                    )
                  : Text(
                      city,
                      style: GlobalTextStyle.cityStyle,
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
      future: data.WeatherAPIs.callTodayAPI(data.appKey, _city),
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

            //Widget Builder
            return body.ApiWidget(
              hasData: true,
              city: _city,
              currTemp: _currTemp,
              minTemp: _minTemp,
              maxTemp: _maxTemp,
              main: _main,
              description: _description,
            );
          } else {
            return Container();
          }
        } catch (exception) {
          //Another Widget
          print(exception);

          return body.ApiWidget(
            city: _city,
            hasData: false,
          );
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
        this._tempCity = data.defaultCity;
      } else {
        //setting city to whatever value
        this._tempCity = results["value"];
      }
    } catch (exception) {
      print(exception);
    }
  }
}
