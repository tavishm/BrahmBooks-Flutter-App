import 'dart:convert';
import 'dart:developer';
//import 'dart:html';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import "book_info.dart";
import 'initial-screen.dart';
import 'main.dart';
import 'otp_verify_screen.dart';


Future<Set<Marker>> mapfetchpost(lat, lng, context) async {
  log(dummy_api +
      '/booksnearby/?lat=' +
      Uri.encodeFull(lat.toString()) +
      "&lng=" +
      Uri.encodeFull(lng.toString()) +
      "&from=0&to=200");
  var response = await http.get(dummy_api +
      '/booksnearby/?lat=' +
      Uri.encodeFull(lat.toString()) +
      "&lng=" +
      Uri.encodeFull(lng.toString()) +
      "&from=0&to=200");
  Map jsresp = json.decode(response.body);
  // var jsd = Post.fromJson(jsresp);
  List<Marker> markers = [];
  for (var entity_dict = 0;
      entity_dict < jsresp['entities'].length;
      entity_dict++) {
    log(entity_dict.toString());
    for (var dictances_dict = 0;
        dictances_dict < jsresp['entities'][entity_dict]['distances'].length;
        dictances_dict++) {
      log(dictances_dict.toString());
      log(jsresp['entities'][entity_dict]['distances'][dictances_dict]['lat']
          .toString());
      log(jsresp['entities'][entity_dict]['distances'][dictances_dict]['lng']
          .toString());
      final http.Response response22 = await http.get(jsresp['entities'][entity_dict]["image"]);
      markers.add(Marker(
        onTap: (){
          log("tapped marker");

          runApp(BookInfo(
                  infostuff: jsresp['entities'][entity_dict],
                ));
        },
        markerId: MarkerId(jsresp['entities'][entity_dict]["bookname"]),
        position: LatLng(
            jsresp['entities'][entity_dict]['distances'][dictances_dict]['lat'],
            jsresp['entities'][entity_dict]['distances'][dictances_dict]
                ['lng']),
        //  position: LatLng(0,0),
        icon: BitmapDescriptor.fromBytes(response22.bodyBytes),
        infoWindow: InfoWindow(title: jsresp['entities'][entity_dict]["bookname"]),
      ));
    }
  }
  Set<Marker> markersn = markers.toSet();
  return markersn;
}

Future<List> nearby_books_fetchpost() async {
  var lat = await read_lat();
  var lng = await read_lng();
  log(dummy_api +
      '/booksnearby/?from=0&to=500&lat=' +
      Uri.encodeFull(lng) +
      "&lng=" +
      Uri.encodeFull(lng));
  var response = await http.get(dummy_api +
      '/booksnearby/?from=0&to=500&lat=' +
      Uri.encodeFull(lng) +
      "&lng=" +
      Uri.encodeFull(lng));
  log("post response");
  Map jsresp = json.decode(response.body);
  log("output popular");
  log(jsresp['entities'].toString());
  return jsresp['entities'];
}

Future mylibraryfetchpost() async {
  var deviceuid = await read_deviceuid();
  log(dummy_api + '/mylibrary/?deviceuid=' + Uri.encodeFull(deviceuid));
  var response = await http
      .get(dummy_api + '/mylibrary/?deviceuid=' + Uri.encodeFull(deviceuid));
  Map jsresp = json.decode(response.body);
  return jsresp['entities'];
}

Future<List> nearby_alphabetic_books(query) async {
  log("I should be here begins");
  var lat = await read_lat();
  var lng = await read_lng();
  log("I should be here");
  log(dummy_api +
      '/alphabeticclosebooks/?lat=' +
      Uri.encodeFull(lng) +
      "&lng=" +
      Uri.encodeFull(lng) +
      "&from=0&to=500&alphabets=" +
      query);
  var response = await http.get(dummy_api +
      '/alphabeticclosebooks/?lat=' +
      Uri.encodeFull(lat) +
      "&lng=" +
      Uri.encodeFull(lng) +
      "&from=0&to=500&alphabets=" +
      query);
  Map jsresp = json.decode(response.body);
  return jsresp['entities'];
}

Future<List> easyrequestpagefetchpost() async {
  var deviceuid = await read_deviceuid();
  log(deviceuid);
  log(dummy_api +
      '/easyfeedpage/?deviceuid=' +
      Uri.encodeFull(deviceuid));
  var response = await http.get(dummy_api +
      '/easyfeedpage/?deviceuid=' +
      Uri.encodeFull(deviceuid));
  Map jsresp = json.decode(response.body);
  return jsresp['entities'];
}

Future<List> get_alphabetic_books(query) async {
  var response = await http.get(dummy_api +
      '/getalphabeticbook/?from=0&to=50&alphabets=' +
      Uri.encodeFull(query));
  Map jsresp = json.decode(response.body);
  return jsresp['entities'];
}

Future<List> get_feed_currently_search(query) async {
  log("post loc");
  if (query.isEmpty) {
    var nearby_respo = await nearby_books_fetchpost();
    return nearby_respo;
  } else {
    var nearby_respo = await nearby_alphabetic_books(query);
    return nearby_respo;
  }
}

Future<String> interprimeinfofetchpost(interprimeid) async {
  print(interprimeid);
  var deviceuid = await read_deviceuid();
  log(dummy_api +
      '/interprimeinfo/?deviceuid=' +
      Uri.encodeFull(deviceuid) +
      '&interprimeid=' +
      Uri.encodeFull(interprimeid));
  var response = await http.get(dummy_api +
      '/interprimeinfo/?deviceuid=' +
      Uri.encodeFull(deviceuid) +
      '&interprimeid=' +
      Uri.encodeFull(interprimeid));
  log(response.body);
  Map jsresp = json.decode(response.body);
  var output = jsresp["entities"]["stage"].toString()+jsresp["entities"]["user"].toString();
  return output;
}

Future<Map> stagedactionsapi(stage, secondhelp, {interprimeid=null, interhelpid=null, ownid=null, book1=null}) async {
  interprimeid = interprimeid.toString();
  interhelpid = interhelpid.toString();
  ownid = ownid.toString();
  book1 = book1.toString();
  stage = stage.toString();
  secondhelp = secondhelp.toString();
  var deviceuid = await read_deviceuid();
  log(dummy_api +
      '/stagedactions/?stage=' +
      Uri.encodeFull(stage) +
      '&secondhelp=' +
      Uri.encodeFull(secondhelp) +
      '&deviceuid=' +
      Uri.encodeFull(deviceuid) +
      '&ownid=' +
      Uri.encodeFull(ownid) +
      '&interid=' +
      Uri.encodeFull(interprimeid) +
      '&interhelpid=' +
      Uri.encodeFull(interhelpid) +
      '&book1=' +
      Uri.encodeFull(book1));
  http.get(dummy_api +
      '/stagedactions/?stage=' +
      Uri.encodeFull(stage) +
      '&secondhelp=' +
      Uri.encodeFull(secondhelp) +
      '&deviceuid=' +
      Uri.encodeFull(deviceuid) +
      '&ownid=' +
      Uri.encodeFull(ownid) +
      '&interid=' +
      Uri.encodeFull(interprimeid) +
      '&interhelpid=' +
      Uri.encodeFull(interhelpid) +
      '&book1=' +
      Uri.encodeFull(book1)
  );
}

Future<Map> own_id_info(ownid) async {
  var lat = await read_lat();
  var lng = await read_lng();
  var response = await http.get(dummy_api +
      '/getownidinfo/?lat=' +
      Uri.encodeFull(lat) +
      '&lng=' +
      Uri.encodeFull(lng) +
      '&ownid=' +
      Uri.encodeFull(ownid));
}

Future<http.Response> login_fetch_post(context, phone) async {
  save_phone(phone);
  log(dummy_api + '/login/?phone=' + Uri.encodeFull(phone));
  var response = await http
      .get(dummy_api + '/login/?phone=' + Uri.encodeFull(phone));
  Map jsresp = json.decode(response.body);
  log("login fetchpost is running babu");
  var jsd = Post.fromJson(jsresp);
  log("login fetchpost is running lalu");
  if (jsresp['result'] as bool == true) {
    showtoast("you have recieved an otp");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OTP_screen()),
    );
  } else if (jsresp['entities'] == 'you just logged in from another device') {
    showtoast("you just logged in from another device");
  } else {
    showtoast(
        "Something went wrong please report it to mankash.abhimanyu@gmail.com");
  }
}

Future<http.Response> helpfetchpost(help, email) async {
  var response = await http.get(dummy_api +
      '/help/?query=' +
      Uri.encodeFull(help) +
      '&email=' +
      Uri.encodeFull(email));
}

Future<http.Response> add_book_to_library(bookid) async {
  bookid = bookid.toString();
  log("count me");
  var lat = await read_lat();
  lat = lat.toString();
  log("count me");
  var lng = await read_lng();
  lng = lng.toString();
  log("count me");
  var deviceuid = await read_deviceuid();
  log("count me");
  log(dummy_api +
      '/addtolibrary?lat=' +
      Uri.encodeFull(lat) +
      '&lng=' +
      Uri.encodeFull(lng) +
      '&deviceuid=' +
      Uri.encodeFull(deviceuid) +
      '&bookid=' +
      Uri.encodeFull(bookid));

  var response = await http.get(dummy_api +
      '/addtolibrary?lat=' +
      Uri.encodeFull(lat) +
      '&lng=' +
      Uri.encodeFull(lng) +
      '&deviceuid=' +
      Uri.encodeFull(deviceuid) +
      '&bookid=' +
      Uri.encodeFull(bookid));
}

Future<http.Response> feedbackfetchpost(feedback, email) async {
  var response = await http.get(dummy_api +
      '/feedback/?feedback=' +
      Uri.encodeFull(feedback) +
      '&email=' +
      Uri.encodeFull(email));
}

Future<http.Response> editnamefetchpost(name) async {
  var deviceuid = await read_deviceuid();
  log(dummy_api + '/editname/?deviceuid=' + Uri.encodeFull(deviceuid)+"&name="+Uri.encodeFull(name));
  var response = await http.get(
      dummy_api + '/editname/?deviceuid=' + Uri.encodeFull(deviceuid)+"&name="+Uri.encodeFull(name));
  var jsresp = json.decode(response.body);
  if (jsresp["result"] as bool==true){
    save_name(name);
  }
}

Future<http.Response> logoutfetchpost() async {
  var deviceuid = await read_deviceuid();
  var response = await http.get(
      dummy_api + '/logout/?deviceuid=' + Uri.encodeFull(deviceuid));
}

Future<http.Response> otpfetchpost(context, pin) async {
  String phone = await read_phone();
  var response = await http.get(dummy_api +
      '/otpverify/?otp=' +
      Uri.encodeFull(pin) +
      '&phone=' +
      Uri.encodeFull(phone));
  Map jsresp = json.decode(response.body);
  if (jsresp['result'] as bool == true) {
    await save_deviceuid(jsresp["entities"]);
    showtoast("Logging you in...");
    runApp(MyApp());
  } else if (jsresp['entities'] == 'late') {
    showtoast("You answered late.");
  } else if (jsresp['entities'] == 'retry') {
    showtoast("You entered the wrong OTP");
  } else {
    showtoast(
        "Something went wrong please report it to mankash.abhimanyu@gmail.com");
  }
}

Future<http.Response> resendotpfetchpost() async {
  var phone = await read_phone();
  var phone_encode = Uri.encodeFull(phone);
  var response =
      await http.get(dummy_api + '/resendotp/?phone=' + phone_encode);
  Map jsresp = json.decode(response.body);
  if (jsresp['result'] as bool == false) {
    showtoast(
        "Something unexpected happened. Please report this to mankash.abhimanyu@gmail.com");
  }
  else {
    showtoast( "OTP resent" );
  }
}

getnamefetchpost() async {
  var deviceuid = await read_deviceuid();
  var deviceuid_encoded = Uri.encodeFull(deviceuid);
  var response =
  await http.get(dummy_api + '/getprofileinfo/?deviceuid=' + deviceuid_encoded);
  Map jsresp = json.decode(response.body);
  if (jsresp['result'] as bool == false) {
    showtoast(
        "Something unexpected happened. Please report this to mankash.abhimanyu@gmail.com");
  }
  else {
    save_name(jsresp["entities"]["name"]);
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
    showtoast(
        "Something went wrong please report it to mankash.abhimanyu@gmail.com");
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
      fontSize: 16.0);
}
Widget botbubble(child){
  return Bubble(
    margin: BubbleEdges.only( top: 10 ),
    alignment: Alignment.topLeft,
    nipWidth: 8,
    nipHeight: 24,
    nip: BubbleNip.leftTop,
    color: Color.fromRGBO( 225, 255, 225, 1 ),
    child: child,
  );
}


Widget userbubble(child){
  return Bubble(
    margin: BubbleEdges.only( top: 10 ),
    alignment: Alignment.topRight,
    nipWidth: 8,
    nipHeight: 24,
    nip: BubbleNip.rightTop,
    color: Color.fromRGBO( 225, 255, 225, 1.0 ),
    child: child,
  );
}

save_deviceuid(deviceuid) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'deviceuid';
  prefs.setString(key, deviceuid);
}

Future<String> read_deviceuid() async {
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

Future<String> read_phone() async {
  final prefs = await SharedPreferences.getInstance();
  final key = "phone";
  final out = prefs.getString(key) ?? '';
  log(out);
  return out;
}

save_name(name) async {
  final prefs = await SharedPreferences.getInstance();
  final key = "name";
  prefs.setString(key, name);
}

Future<String> read_name() async {
  final prefs = await SharedPreferences.getInstance();
  final key = "name";
  final out = prefs.getString(key) ?? '';
  log(out);
  return out;
}

void firsttwolettersofname() async {
  firstdigs_main = await read_name();
  firstdigs_main = firstdigs_main.substring(0, 2);
}

save_latlng(lat, lng) async {
  final prefs = await SharedPreferences.getInstance();
  final key1 = "lat";
  final key2 = "lng";
  prefs.setString(key1, lat.toString());
  prefs.setString(key2, lng.toString());
}

Future<List<String>> read_latlng() async {
  final prefs = await SharedPreferences.getInstance();
  final key1 = "lat";
  final key2 = "lng";
  final lat = prefs.getString(key1) ?? '';
  final lng = prefs.getString(key2) ?? '';
  log(lat + lng);
  return [lat, lng];
}

Future<String> read_lat() async {
  final prefs = await SharedPreferences.getInstance();
  final key1 = "lat";
  final lat = prefs.getString(key1) ?? '';
  return lat;
}

Future<String> read_lng() async {
  final prefs = await SharedPreferences.getInstance();
  final key2 = "lng";
  final lng = prefs.getString(key2) ?? '';
  return lng;
}
