import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: Align(
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black,
          ),
          onPressed: () => toWeather(context),
        ),
      ),
    );
  }
}

void toWeather(BuildContext context) {
  Navigator.of(context).pushNamed("/weather");
}
