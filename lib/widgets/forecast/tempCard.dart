import 'package:flutter/material.dart';

class TempCard extends StatelessWidget {
  final String temp;
  final String type;

  const TempCard({this.type, this.temp});

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
