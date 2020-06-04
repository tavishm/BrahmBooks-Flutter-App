import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import 'dart:io';
import 'utils.dart';

void main() {
  runApp(myLibrary());
}

class myLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("my library"),
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: Card(
                    child: Row(children: <Widget>[

                  Image.network(
                      'http://ecx.images-amazon.com/images/I/512O7wP2d%2BL.jpg'),
                  Column(children: <Widget>[
                    Text("Travels in the Greater Yellowstone"),
                    Text("Jack Turner")
                  ])
                ]))),
          ],
        ),
      ),
    );
  }
}
