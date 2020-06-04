import 'package:fluttertoast/fluttertoast.dart';

import 'utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'main.dart';
import 'otp_verify_screen.dart';

var dummy_api = "http://192.168.1.110:8000";
var myControlph1 = TextEditingController();
var myControlph = TextEditingController();
var myControlname = TextEditingController();


Brightness themevar = Brightness.light; // full app brightness
MaterialColor themecol = Colors.cyan; // full app color
Color backgroundcol = Colors.white; // for background color
void main() => runApp(TyApp());

class TyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log("Bypass 'if'");

    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text("Brahm Books"),
          trailing: IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => about()),
              );
            },
          ),
        ),
        body: Column(children: <Widget>[
      // Row(children: <Widget>[
      Center(
        child: Image.asset('images/book_op_2.png'),
      ),

      Expanded(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        child: RaisedButton(
                            color: CupertinoColors.activeBlue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()),
                              );
                            },
                            child: Text('Signup'))),
                  )),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            child: RaisedButton(
                              child: Text('Login'),
                              color: CupertinoColors.activeBlue,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                            ))),
                  ),
                ],
              )))
    ]));
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text("Login to Brahm Books"),
          trailing: IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => about()),
              );
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(10),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    controller: myControlph,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    style: Theme.of(context).textTheme.display1,
                    decoration: InputDecoration(
                      labelText: 'your phone number',
                      labelStyle: Theme.of(context).textTheme.display1,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                )),
            Center(
                child: Container(
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Text(
                      "Phone number should contain no symbols or whitespace",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ))),
            Container(
                margin: const EdgeInsets.all(10),
                child: CupertinoButton(
                    child: Text("verify!"),
                    color: CupertinoColors.activeBlue,
                    onPressed: () {
                      save_phone(myControlph.text);
                      bool PhoneValid =
                          RegExp(r"^[0-9]{10}$").hasMatch(myControlph.text);
                      if (!PhoneValid) {
                        Fluttertoast.showToast(
                            msg: "phone number is not valid",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        login_fetch_post(context, myControlph.text);
                        log("login fetchPost is running!!!");
                      }
                    })),
          ],
        ));
  }
}

class Signup extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text("Join Brahm Books"),
          trailing: IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => about()),
              );
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: TextField(
                  maxLength: 10,
                  controller: myControlph,
                  keyboardType: TextInputType.phone,
                  style: Theme.of(context).textTheme.display1,
                  decoration: InputDecoration(
                    labelText: 'your phone number',
                    labelStyle: Theme.of(context).textTheme.display1,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Center(
                child: Container(
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Text(
                      "Phone number should contain no symbols or whitespace",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ))),
            Container(
                margin: const EdgeInsets.all(10),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    maxLength: 1024,
                    keyboardType: TextInputType.text,
                    controller: myControlname,
                    style: Theme.of(context).textTheme.display1,
                    decoration: InputDecoration(
                      labelText: 'name',
                      labelStyle: Theme.of(context).textTheme.display1,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                )),
            Container(
                margin: const EdgeInsets.all(10),
                child: CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    child: Text("Sign-up!"),
                    onPressed: () {
                      save_phone(myControlph.text);
                      save_name(myControlname.text);
                      bool PhoneValid =
                          RegExp(r"^[0-9]{10}$").hasMatch(myControlph.text);
                      if (!PhoneValid) {
                        Fluttertoast.showToast(
                            msg: "phone number is not valid",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (myControlname.text == "") {
                        log(myControlname.text);
                        Fluttertoast.showToast(
                            msg: "Please mention your name",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        signup_fetchpost(context, myControlph.text, myControlname.text);
                      }
                    }))
          ],
        ));
  }
}



class Post {
//  final String fulltext;
  Post({this.result, this.entities});

  factory Post.fromJson(Map jsData) {
    return Post(
      result: jsData['result'] as bool,
      entities: jsData['entities'] as String,
    );
  }

  final String entities;
  final bool result;
}
