import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import "package:flutter/cupertino.dart";

void main() => runApp(conversation());

class conversation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('conversations tab'),
          ),
          body: ListView(children: <Widget>[
            Bubble(
                margin: BubbleEdges.only(top: 10),
                alignment: Alignment.topRight,
                nipWidth: 8,
                nipHeight: 24,
                nip: BubbleNip.rightTop,
                color: Color.fromRGBO(225, 255, 199, 1.0),
                child: Column(children: <Widget>[
                  Text("hello World!!!", textAlign: TextAlign.right),
                  Image.network(
                      "http://ecx.images-amazon.com/images/I/41RX7hoxFXL.jpg"),
                ])),
          ])),
    );
  }
}
