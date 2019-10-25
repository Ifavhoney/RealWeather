import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/widgets/header/header.dart' as header;

class ChangeCity extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header.BaseAppBar(
        appBar: AppBar(),
        backgroundColor: Colors.lightBlue,
        title: Text("Change City"),
      ),
      // bottomNavigationBar: ,
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Image.asset(
              "images/white_snow.png",
              height: 1000,
              width: 1000,
              fit: BoxFit.cover,
            ),
            //  top: 200,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: TextField(
              decoration: InputDecoration(hintText: "Enter City"),
              controller: _controller,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(140, 90, 0, 0),
            child: RaisedButton(
              color: Colors.deepOrange,
              child: Text("Submit"),
              onPressed: () {
                if (_controller.text == null ||
                    _controller.text.trim().isEmpty) {
                  //_Sending
                  _controller.text = "Toronto";
                }
                addStringToSF(_controller.text);

                Navigator.of(context).pop({"value": _controller.text});

                print(_controller.text);
              },
            ),
          )
        ],
      ),
    );
  }

  addStringToSF(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue', val);
    //  print(val);
  }
}
