import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String _title;
  Header(this._title);

  @override
  Widget build(BuildContext context) {
    return appBar(_title, ctx: context);
  }
}

AppBar appBar(String title, {BuildContext ctx}) {
  AppBar(
    leading: Container(),
    title: Text(title),
    backgroundColor: Colors.brown,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.navigate_next),
        onPressed: () {
          //calls changeScreens
          //changeScreens(ctx);
        },
      )
    ],
  );
}
