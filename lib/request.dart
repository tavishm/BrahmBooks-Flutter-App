import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'dart:async';
import 'package:geolocation/geolocation.dart';
import 'dart:developer';
import 'book-info1.dart';
import 'utils.dart';
import 'initial-screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'account.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'initial-screen.dart';
import "library.dart";
import "help.dart";
import "feedback.dart";
import "book_info.dart";
import "main.dart";

Widget _child;
class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;
  Position position;

  @override
  void initState() {
    _child = Column(children: <Widget>[
      Spacer(flex: 1),
      Flexible(
          flex: 2,
          child: Center(
            child: Container(
                color: CupertinoColors.white,
                child: SpinKitChasingDots(
                  color: CupertinoColors.black,
                  size: 250.0,
                )),
          )),
      Flexible(flex: 1, child: Center(child: Text("Is location turned on?"))),
    ]);
    super.initState();
    getCurrentLocation();
    firsttwolettersofname();
  }

  void getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    log("post res");
    save_latlng(res.latitude, res.longitude);
    markers = await mapfetchpost(res.latitude, res.longitude);
    log("post markers");
    setState(() {
      position = res;
      _child = mapWidget();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget mapWidget() {
    return GoogleMap(
      indoorViewEnabled: true,
      mapType: MapType.terrain,
      buildingsEnabled: true,
      compassEnabled: true,
      markers: markers,
      onMapCreated: _onMapCreated,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15,
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        brightness: Brightness.light,
      ),
      //home:
      /*initialRoute: '/',
        routes: {
          '/': (context) => MyAppView(),
          '/second': (context) => profile(),
        }*/
      home: null,
    );
  }
}
class Request extends StatelessWidget{  final GlobalKey<ScaffoldState> _scaffoldKey =
new GlobalKey<ScaffoldState>();@override
  Widget build(BuildContext context) {
  return DefaultTabController(child:  Scaffold(appBar: AppBar(title: Text("this is req. tab")),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showSearch(
              context: context,
              delegate: SearchPage132());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            title: Text("Explore"),
            icon: IconButton(tooltip: "Get", icon: Icon(Icons.book), onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );}),
          ),
          BottomNavigationBarItem(
              title: Text("Requests"),
              icon: IconButton(
                icon: Icon(Icons.question_answer),
                onPressed: () {},
                tooltip: "requests",
              )),
        ],
      ),
      body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Stack(
              children: <Widget>[
                // Replace this container with your Map widget
                Container(
                  child: _child,
                ),
                Positioned(
                  top: 40,
                  right: 15,
                  left: 15,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Opacity(
                            child: IconButton(
                              tooltip: "menu",
                              icon: Icon(Icons.menu),
                              onPressed: () {
                                _scaffoldKey.currentState.openDrawer();
                              },
                            ),
                            opacity: 0.5,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onTap: () {
                              showSearch(
                                  context: context,
                                  delegate: SearchPage());
                            },
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.go,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 15),
                              hintText: "Search here",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Opacity(
                            child: Icon(Icons.search),
                            opacity: 0.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            backgroundColor: CupertinoColors.activeBlue,
                            child: Text(firstdigs_main),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text("Hola"),
          ])));
  }}