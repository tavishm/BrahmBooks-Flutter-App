import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(example());

class example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CupertinoNavigationBar(),
        body: SafeArea(
            child: Column(children: <Widget>[
          Row(children: <Widget>[
            Image.asset('images/harrypotter.jpg'),
            Text(
              "   Harry Potter and the \n   chamber of secrets",
              style: TextStyle(fontSize: 20),
            ),
          ]),
              Text(""),

              Text("distance: 40m ",              style: TextStyle(fontSize: 15),
              ),
          FlatButton( onPressed: ()  {("hahahahah");}, child: Text("Exchange!"))
        ])),
      ),
    );
  }
}
