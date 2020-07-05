import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import 'utils.dart';
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


var dummy_api = "192.168.1.110:8000";
var myControlnamechange = TextEditingController();


void main() {
  runApp(profile());
}

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Future<void> initState() {
    super.initState();
    firsttwolettersofname();
  }

  @override
  Widget build(context) {
    return MaterialApp(
        home: SafeArea(
            child: Scaffold(
                appBar: CupertinoNavigationBar(middle: Text("My Account")),
                body: Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 30),
      child: Column(
        children: <Widget>[
          Center(
              child: CircleAvatar(
            radius: 100,
            backgroundColor: CupertinoColors.black,
            child: Text(firstdigs_main,
                style: TextStyle(
                    height: 1, fontSize: 50, color: CupertinoColors.white)),
          )),
          Container(
            margin: const EdgeInsets.all(10),
            //child: Text("Abhimanyu Mankash"),
            child: TextFormField(
              controller: myControlnamechange,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Call me ...',
                labelText: "Your new name",
              ),
              /*   onSaved: (String value) {

                  },*/
            ),
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: RaisedButton(
                          child: Text("Submit"),
                          onPressed: () {
                            editnamefetchpost(myControlnamechange.text);
                            showDialog(context: context,
                            builder: (_) => AlertDialog(
                                title: Text('Close the app'),
                            content: SingleChildScrollView(
                            child: ListBody(
                            children: <Widget>[
                            Text('Close this app to apply changes.'),
                            ],
                            ),
                            ),
                            ));
                          }),
                    )),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: RaisedButton(
                                child: Text("Logout"),
                                onPressed: () {
                                  logoutfetchpost();
                                  save_deviceuid("0");
                                  runApp(TyApp());
                                })))
                  ]))),
        ],
      ),
    ))));
  }
}
