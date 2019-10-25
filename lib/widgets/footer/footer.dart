import 'package:flutter/material.dart';
import 'package:weather/screens/weather.dart';
import 'package:weather/screens/forecast.dart';

class Footer extends StatefulWidget {
  int currentIndex;
  final String city;

  Footer({@required this.currentIndex, this.city});

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: widget.currentIndex,
        backgroundColor: Colors.lightBlue,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        selectedLabelStyle:
            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        // selectedFontSize: 14,
        selectedIconTheme: IconThemeData(size: 40),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              "Home",
            ),
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.cloud),
              icon: Icon(Icons.cloud),
              title: Text(
                "Forecast",
                //      style: TextStyle(color: Colors.white),
              )),
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh),
            title: Text(
              "Change City",
              //  style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            title: Text(""),
            icon: Row(
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 40,
                ),
                Text(widget.city)
              ],
            ),
          ),
        ],
        onTap: (int index) {
          setState(() {
            widget.currentIndex = index;
            if (widget.currentIndex < 3) {
              redirect(widget.currentIndex);
            }
            // print(_currentIndex);
          });
        });
  }

  Future redirect(int index) async {
    switch (index) {
      case 0:
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) {
          return Weather(prevCity: widget.city);
        });
        return await Navigator.of(context).push(route);
        break;

      case 1:
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) {
          return Forecast(
            city: widget.city,
          );
        });
        return await Navigator.of(context).push(route);

        break;

      case 2:
        widget.currentIndex--;
        print(widget.currentIndex);
        return Navigator.pushNamed(context, "/changeCity");
        break;

      default:
        return null;
    }
  }
}
