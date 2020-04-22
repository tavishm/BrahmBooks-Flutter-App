//import 'dart:wasm';
import 'package:fluttertoast/fluttertoast.dart';

import 'utils.dart';
import 'package:brahm_books/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'signup-page.dart';
import 'main.dart';
import 'login-page.dart';
import 'otp_verify_screen.dart';

final myControlph1 = TextEditingController();
final myControlph = TextEditingController();
final myControlname = TextEditingController();


Brightness themevar = Brightness.light; // full app brightness
MaterialColor themecol = Colors.cyan; // full app color
Color backgroundcol = Colors.white; // for background color
var domain = "192.168.1.110";
void main() => runApp(TyApp());




class TyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log('came to if');
    if (read_uid() == '0') {
      log("\n\nO is read_uid\n\n");
      Future<http.Response> fetchPost() async {
        //<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
      var response = await http
            .get('http://brahm.ai/brahm/brahm_books/asigndeviceuid.py');
      Map jsresp = json.decode(response.body);
      var jsd = Post.fromJson(jsresp);
      if (jsresp['result'] as bool == true){
        save_deviceid(jsresp['deviceuid']);
      }else{
        Fluttertoast.showToast(msg: "check your network!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        throw Exception("This is a crash!");
      }
      }

    }

    log("Bypass 'if'");

    return MaterialApp(
      home: Scaffold(
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
          body: new HomeScreen()),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // Row(children: <Widget>[
      Center(
        child: Image.asset('images/books_copy_copy.png'),
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
                        borderRadius:  BorderRadius.all(Radius.circular(25)),
                        child: RaisedButton(
                        color: CupertinoColors.activeBlue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
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
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                        ))),
                  ),
                ],
              )))
    ]);
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
                    onPressed: () {bool PhoneValid = RegExp(r"^[0-9]{10}$").hasMatch(myControlph.text);
                    if (!PhoneValid) {
                      Fluttertoast.showToast(msg: "phone number is not valid",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }else{

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OTP_screen()),
                      );
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
                      bool PhoneValid = RegExp(r"^[0-9]{10}$").hasMatch(myControlph.text);
                      if (!PhoneValid) {
                        Fluttertoast.showToast(msg: "phone number is not valid",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (myControlname.text == ""){
                        log(myControlname.text);
                        Fluttertoast.showToast(msg: "Please mention your name",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Future<http.Response> fetchPost2() async {
                          //<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts])
                          log('brahm.ai/brahm/brahm_books/signup_api.py?phone=' +
                                  myControlph.text + '&name=' +
                                  myControlname.text + '&deviceuid=' +
                                  read_uid());
                          var response = await http
                              .get(
                              'brahm.ai/brahm/brahm_books/signup_api.py?phone=' +
                                  myControlph.text + '&name=' +
                                  myControlname.text + '&deviceuid=' +
                                  read_uid());
                          Map jsresp = json.decode(response.body);
                          var jsd = Post.fromJson(jsresp);
                          if (jsresp['result'] as bool == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTP_screen()),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "An error occured, please report"
                                    "it to mankash.abhimanyu@gmail.com",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OTP_screen()),
                        );
                      }
                    }))
          ],
        ));
  }
}


/*class otp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        body: Scaffold(
          appBar: CupertinoNavigationBar(middle: Text("Verify OTP")),
          body: Column(
            children: <Widget>[
              Text('verify your otp'),
              Center(
                  child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: '__ __ __ __ __ __'),
              )),
              CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: Text("verify!"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  })
            ],
          ),
        ));
  }
}
*/

class Post {
//  final String fulltext;
  Post({this.result, this.deviceuid});

  factory Post.fromJson(Map jsData) {
    return Post(
      result: jsData['result'] as bool,
      deviceuid: jsData['deviceuid'] as String,

    );
  }

  final String deviceuid;
  final bool result;
}
