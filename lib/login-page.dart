import 'dart:convert';
/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'initial-screen.dart';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';


final accountcont = TextEditingController();
final passwordcont = TextEditingController();

List<String> coded = ["#","\$","%","&","'","(",")","*","+",",","/",":",";","=","?","@","[","]"]; //ABV list
List<String> decoded = ["%23","%24","%25","%26","%27","%28","%29","%2A","%2B","%2C","%2F","%3A","%3B","%3D","%3F","%40","%5B","%5D"]; //corresponding list
Map<String, String> map = new Map.fromIterables(coded, decoded);



class loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: backgroundcol,
        appBar: AppBar(
          centerTitle: true,
          title: RichText(
            //  textAlign: TextAlign.center,
              text: new TextSpan(
                  style: new TextStyle(fontSize: 18),
                  children: <TextSpan>[
                    new TextSpan(
                        style: new TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.black),
                        text: "Brahm Talk ")
                  ])),
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.yellow[200], Colors.green[200], Colors.cyan[200]])),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[

              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 0, left: 20, right: 20),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    controller: accountcont,
                    maxLength: 32,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.display1,
                    decoration: InputDecoration(
                      labelText: 'Brahm ID',
                      labelStyle: Theme.of(context).textTheme.display1,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 45, left: 20, right: 20),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextFormField(
                    controller: passwordcont,
                    maxLength: 512,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: Theme.of(context).textTheme.display1,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: Theme.of(context).textTheme.display1,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                  margin: const EdgeInsets.all(10),
                  child: RaisedButton(
                    child: Text("Get Started!"),
                    //      textColor: Colors.black,
                    onPressed: () {
                      //   Text(""),
                      var accountname = accountcont.text;
                      var password = passwordcont.text;
                      log(password);
                      accountname = Uri.encodeFull(accountname);
                      password = Uri.encodeFull(password);
                      //accountname = map.entries.fold(accountname,
                      //        (prev, e) => prev.replaceAll(e.key, e.value));
                      //password = map.entries.fold(password,
                      //      (prev, e) => prev.replaceAll(e.key, e.value));
                      //   accountname =

                      log(accountname);


                      Future<bool> fetchPost2() async {
                        //<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
                        log(
                            'http://brahm.ai/brahmtalk/login_acc.py?acc='+accountname+'&pass='+password
                        );
                        var response = await http.get(
                            'http://brahm.ai/brahmtalk/login_acc.py?acc='+accountname+'&pass='+password);
                        log(response.body);
                        var resp = json.decode(response.body);
                        if (resp['ans']==true){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => contacts()),
                          );
                          log("Logged in Successfully!");
                          Fluttertoast.showToast(
                              msg: "Successfully Loged-in",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 2,
                              backgroundColor: Colors.black26,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          _save(accountname, password);
                          return false;
                        }else{
                          Fluttertoast.showToast(
                              msg: "The username or password in incorrect",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 2,
                              backgroundColor: Colors.black26,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return true;
                        }
                      }
                      //future:
                      Future<bool> r = fetchPost2();

                      runApp(MyApp());
                      build(context);

                    },
                    //                 controller: myController,
                  ))

            ],
          ),
        )
    );
  }
}



_read() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'acc_name';
  final pakey = 'passwd';
  final value = prefs.getString(key) ?? 0;
  final pass = prefs.getString(pakey) ?? 0;
  return [value, pakey];
}

_save(accname, passwd) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'acc_name';
  final pakey = 'passwd';
  prefs.setString(key, accname);
  prefs.setString(pakey, passwd);
}
*/
