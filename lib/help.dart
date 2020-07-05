import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:developer';
import 'utils.dart';
import 'initial-screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'initial-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'initial-screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'otp_verify_screen.dart';
import 'dart:convert';
import 'main.dart';

final myControlhelp = TextEditingController();
final myControlemail = TextEditingController();

void main() {
  runApp(help());
}
class help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: CupertinoNavigationBar(middle: Text("Help")),
          body: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top:30, bottom: 30, left: 15, right: 15),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    controller: myControlhelp,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: Theme.of(context).textTheme.display1,
                    decoration: InputDecoration(
                      labelText: "your query",
                      labelStyle: Theme.of(context).textTheme.display1,

                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top:30, bottom: 30, left: 15, right: 15),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    controller: myControlemail,
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
            child: Row(children: <Widget>[
            Expanded(
            child: Padding(
                padding: const EdgeInsets.all(10),
            child: RaisedButton(child: Text("Submit"), onPressed: () {
              showtoast("we will respond to you as soon as possible");
              helpfetchpost(myControlhelp.text, myControlemail.text);
            }),)
    )],
          ),
        ))])));
  }
}