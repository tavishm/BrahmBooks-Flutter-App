//import 'dart:wasm';
import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:flutter/rendering.dart';
import 'initial-screen.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'dart:developer';
import 'utils.dart';
import 'dart:convert';

void main() => about();

class OTP_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text("Verify OTP"),
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
          Container(
              margin: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "You have received an OTP via sms on your phone. Please enter the OTP below.",
                  textAlign: TextAlign.center,
                ),
              )),
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: PinEntryTextField(
              fields: 6,
              onSubmit: (pin) {
                otpfetchpost(context, pin);
              },
            ),
          ),
          Center(
              child: CupertinoButton(
                  child: Text("why do I have to do this?"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => whyotp()),
                    );
                  })),
          Center(
            child: CupertinoButton(child: Text("Resend otp"), onPressed: (){
              resendotpfetchpost();
            }),
          )
        ]));
  }
}

class whyotp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text("Brahm Books Docs"),
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
        body: ListView(children: <Widget>[
          Container(
              margin: const EdgeInsets.all(20),
              child: Text("Why Should I verify OTP?",
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1, fontSize: 25))),
          Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                  "An OTP(one-time-password) is a 6 digit unique code sent to your phone number to verify if the phone number belongs to you. This is done to prevent people from using this app wth your name. By Verifying using an OTP, we are sure it's you and there are no fake users around you either. To verify your OTP - "
                  "\n\n1. Open messages or any other app that has your sms"
                  "\n\n2. Search for an sms from brahm.ai and open it."
                  "\n\n3. Copy the OTP in it and come back to brahm books"
                  "\n\n4. Click the 'back' button on the top app bar"
                  "\n\n5. Paste the OTP in the Text Box"
                  "\n\n6. You are ready to exchange books!")),
        ]));
  }
}

class about extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text("Brahm Books Docs"),
        ),
        body: ListView(children: <Widget>[
          Container(
              margin: const EdgeInsets.all(20),
              child: Text("What is Brahm Books?",
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1, fontSize: 25))),
          Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                  "Brahm Books is a all-in-one books app where you can exchange your books in your neighbourhood. Brahm books allows you to exchange books around you."
                  "Brahm Books is free. Brahm Books gets you books you need for books you have read. Brahm Books is the best place for your books."
                  "\n\n Brahm books is developed and maintained by brahm.ai. Brahm Books is releasing borrow and but options in Brahm Books soon. Stay tuned for more...",
                  textAlign: TextAlign.center)),
        ]));
  }
}
