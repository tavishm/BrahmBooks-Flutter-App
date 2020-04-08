import 'dart:wasm';
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
final myControlname1 = TextEditingController();
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
    if (read_uid() == '0') {
      Future<http.Response> fetchPost() async {
        //<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
      var response = await http
            .get('http://brahm.ai/brahm/brahm_books/asigndeviceuid.py');
      Map jsresp = json.decode(response.body);
      var jsd = Post.fromJson(jsresp);
      if (jsresp['result'] as bool == true){
        save_deviceid(jsresp['deviceuid']);
      }else{
        throw Exception("This is a crash!");
      }
      }

    }
// parth bhaiya this is the code              are you able to see?              the map code is here
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
                    child: RaisedButton(
                        color: CupertinoColors.activeBlue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                        child: Text('Signup')),
                  )),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: RaisedButton(
                          child: Text('Login'),
                          color: CupertinoColors.activeBlue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                        )),
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
                    maxLength: 12,
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
                      "Phone number should contain country code and no symbols or whitespace",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ))),
            Container(
                margin: const EdgeInsets.all(10),
                child: CupertinoButton(
                    child: Text("verify!"),
                    color: CupertinoColors.activeBlue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OTP_screen()),
                      );
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
                  maxLength: 12,
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
                      "Phone number should contain country code and no symbols or whitespace",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ))),
            Container(
                margin: const EdgeInsets.all(10),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    maxLength: 1024,
                    keyboardType: TextInputType.text,
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
                    child: Text("verify!"),
                    onPressed: () {
                      Future<http.Response> fetchPost2() async {
                        //<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts])
                        var response = await http
                            .get('brahm.ai/brahm/brahm_books/signup_api.py?phone='+myControlph.text+'&name='+myControlname.text+'&deviceuid='+read_uid());
                        Map jsresp = json.decode(response.body);
                        var jsd = Post.fromJson(jsresp);
                        if (jsresp['result'] as bool == true){
                          save_deviceid(jsresp['deviceuid']);
                        }else{
                          throw Exception("This is a crash!");
                        }
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OTP_screen()),
                      );
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
