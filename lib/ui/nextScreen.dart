import 'package:flutter/material.dart';

class NextScreen extends StatelessWidget {
  String _city;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text("City"),
      ),
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

                Navigator.of(context).pop({"value": _controller.text});
                //  print(_controller.text);
              },
            ),
          )
        ],
      ),
    );
  }
}
