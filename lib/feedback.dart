import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'dart:async';
import 'package:geolocation/geolocation.dart';
import 'dart:developer';
import 'utils.dart';
import 'initial-screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'initial-screen.dart';

final myControlfeedback = TextEditingController();
final myControlemailforfeedback = TextEditingController();

void main() {
  runApp(feedback());
}

class feedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Feedback", style: TextStyle(color: Colors.white)),
          backgroundColor: CupertinoColors.activeGreen,
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                  top: 30, bottom: 30, left: 15, right: 15),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: TextField(
                  controller: myControlfeedback,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.display1,
                  decoration: InputDecoration(
                    labelText: 'How can we improve?',
                    labelStyle: Theme.of(context).textTheme.display1,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 30, bottom: 30, left: 15, right: 15),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: TextField(
                  controller: myControlemailforfeedback,
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.display1,
                  decoration: InputDecoration(
                    labelText: 'email-address',
                    labelStyle: Theme.of(context).textTheme.display1,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: RaisedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          showtoast(
                              "we will respond to you as soon as possible");
                          feedbackfetchpost(myControlfeedback.text,
                              myControlemailforfeedback.text);
                        }),
                  ))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
