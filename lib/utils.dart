import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'initial-screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'otp_verify_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:convert';
import 'main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


Future<Set<Marker>> mapfetchpost(lat, lng) async {
  log(dummy_api + '/booksnearby/?lat=' + Uri.encodeFull(lat.toString()) + "&lng="+Uri.encodeFull(lng.toString()) +"&from=0&to=200");
  var response = await http
      .get(dummy_api + '/booksnearby/?lat=' + Uri.encodeFull(lat.toString()) + "&lng="+Uri.encodeFull(lng.toString()) +"&from=0&to=200");
  Map jsresp = json.decode(response.body);
 // var jsd = Post.fromJson(jsresp);
  List<Marker> markers = [];
  for (var entity_dict=0; entity_dict < jsresp['entities'].length; entity_dict++){
    log(entity_dict.toString());
    for (var dictances_dict=0; dictances_dict < jsresp['entities'][entity_dict]['distances'].length; dictances_dict++){
      log(dictances_dict.toString());
      log(jsresp['entities'][entity_dict]['distances'][dictances_dict]['lat'].toString());
      log( jsresp['entities'][entity_dict]['distances'][dictances_dict]['lng'].toString());
      markers.add(Marker(
        markerId: MarkerId("Book"),
        position: LatLng(jsresp['entities'][entity_dict]['distances'][dictances_dict]['lat'], jsresp['entities'][entity_dict]['distances'][dictances_dict]['lng']),
      //  position: LatLng(0,0),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Me"),
      ));
    }
  }
  Set<Marker> markersn = markers.toSet();
  return markersn;

}


Future<List<Map>> popular_booksfetchpost() async {
  log(dummy_api + '/popularbooks/?from=0&to=200');
  var response = await http
      .get(dummy_api + '/popularbooks/?from=0&to=200');
  log(response.body);
  log("post response");
  Map jsresp = json.decode(response.body);
  log("output popular");
  log(jsresp['entities']);
  return jsresp['entities'];

}


Future<List<Map>> nearby_alphabetic_books(lat, lng) async {
  log("I shouldn't be here");
  log(dummy_api + '/booksnearby/?lat=' + Uri.encodeFull(lng) + "&lng="+Uri.encodeFull(lng) +"&from=0&to=200");
  var response = await http
      .get(dummy_api + '/booksnearby/?lat=' + Uri.encodeFull(lat) + "&lng="+Uri.encodeFull(lng) +"&from=0&to=200");
  Map jsresp = json.decode(response.body);
  return jsresp['entities'];
}
Future<List<Map>> get_feed_currently_search(query) async {
  var lat = read_lat();
  var lng = read_lng();
  log("post loc");
  return query.isEmpty?popular_booksfetchpost():nearby_alphabetic_books(lat, lng);
}

Future<http.Response> login_fetch_post(context, phone) async {
  var response = await http
      .get(dummy_api + '/login/?phone=' + Uri.encodeFull(read_phone()));
  Map jsresp = json.decode(response.body);
  var jsd = Post.fromJson(jsresp);
  if (jsresp['result'] as bool == true) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OTP_screen()),
    );
  } else if (jsresp['entities'] == 'you just logged in from another device') {
    showtoast("you just logged in from another device");
  } else {
    showtoast("Something went wrong please report it to mankash.abhimanyu@gmail.com");
  }
}


Future<http.Response> helpfetchpost(help, email) async {
  var response = await http.get(dummy_api +
      '/help/?query=' +
      Uri.encodeFull(help) +
      '&email=' +
      Uri.encodeFull(email)

  );
}
Future<http.Response> feedbackfetchpost(feedback, email) async {
  var response = await http.get(dummy_api +
      '/feedback/?feedback=' +
      Uri.encodeFull(feedback)+
  '&email=' +
      Uri.encodeFull(email)

  );
}
Future<http.Response> editnamefetchpost() async {
  var response = await http.get(dummy_api +
      '/editname/?deviceuid = ' +
      Uri.encodeFull(read_deviceuid()));
}
Future<http.Response> logoutfetchpost() async {
  var response = await http.get(dummy_api +
      '/logout/?deviceuid=' +
      Uri.encodeFull(read_deviceuid()));
}
Future<http.Response> otpfetchpost (context, pin) async {
  String phone_encode = await Uri.encodeFull(read_phone());
  var response = await http.get(dummy_api +
      '/otpverify/?otp=' +
      Uri.encodeFull(pin) +
      '&phone=' +
      phone_encode);
  Map jsresp = json.decode(response.body);
  var jsd = Post.fromJson(jsresp);
  if (jsresp['result'] as bool == true) {
    save_deviceuid(jsresp['entities']);
    runApp(MyApp());
  } else if (jsresp['entities'] == 'late') {
    showtoast("You answered late.");
  }
  else if (jsresp['entities'] == 'retry') {
    showtoast("You entered the wrong OTP");
  }
  else {showtoast("Something went wrong please report it to mankash.abhimanyu@gmail.com");}

}


Future<http.Response> resendotpfetchpost () async {
  var phone_encode=Uri.encodeFull(read_phone());
  var response = await http.get( dummy_api +
      '/resendotp/?phone=' +
      phone_encode
  );
  Map jsresp = json.decode(response.body);
  if (jsresp['result'] as bool == false) {
    showtoast("Something unexpected happened. Please report this to mankash.abhimanyu@gmail.com");
  }
}
Future<http.Response> signup_fetchpost(context, phone, name) async {
  //<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts])
  log('192.168.1.110:8000/signup/?phone=' +
      Uri.encodeFull(phone) +
      '&name=' +
      Uri.encodeFull(name));
  var response = await http.get(dummy_api +
      '/signup/?phone=' +
      Uri.encodeFull(phone) +
      '&name=' +
      Uri.encodeFull(name));

  Map jsresp = json.decode(response.body);
  var jsd = Post.fromJson(jsresp);
  if (jsresp['result'] as bool == true) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OTP_screen()),
    );
  } else if (jsresp['entities'] == 'user already logged in') {
    showtoast("That phone is already registered");
  } else {
    showtoast("Something went wrong please report it to mankash.abhimanyu@gmail.com");
  }
}



showtoast(message_t) {
  return Fluttertoast.showToast(
      msg: message_t,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0 );
}


save_deviceuid(deviceuid) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'deviceuid';
  prefs.setString(key, deviceuid);
}

read_deviceuid() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'deviceuid';
  final out = prefs.getString(key) ?? '0';
  log(out);
  return out;
}

save_phone(phone) async {
  final prefs = await SharedPreferences.getInstance();
  final key = "phone";
  prefs.setString(key, phone);
}


read_phone() async {
  final prefs = await SharedPreferences.getInstance();
  final key = "phone";
  final out = prefs.getString(key) ?? '';
  log(out);
  return out;
}

save_name(MyControlname) async {
  final prefs = await SharedPreferences.getInstance();
  final key = "name";
  prefs.setString(key, MyControlname);
}

read_name() async{
  final prefs = await SharedPreferences.getInstance();
  final key = "name";
  final out = prefs.getString(key) ?? '';
  log(out);
  return out;
}


save_latlng(lat, lng) async {
  final prefs = await SharedPreferences.getInstance();
  final key1 = "lat";
  final key2 = "lng";
  prefs.setString(key1, lat.toString());
  prefs.setString(key2, lng.toString());
}

Future<List<String>> read_latlng() async{
  final prefs = await SharedPreferences.getInstance();
  final key1 = "lat";
  final key2 = "lng";
  final lat = prefs.getString(key1) ?? '';
  final lng = prefs.getString(key2) ?? '';
  log(lat+lng);
  return [lat, lng];
}


Future<String> read_lat() async{
  final prefs = await SharedPreferences.getInstance();
  final key1 = "lat";
  final lat = prefs.getString(key1) ?? '';
  return lat;
}

Future<String> read_lng() async{
  final prefs = await SharedPreferences.getInstance();
  final key2 = "lng";
  final lng = prefs.getString(key2) ?? '';
  return lng;
}
