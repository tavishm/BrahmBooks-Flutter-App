import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'dart:async';
import 'package:geolocation/geolocation.dart';
import 'dart:developer';
import 'utils.dart';
import 'initial-screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

LatLng _center = LatLng(71.43, 56.43);

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;
  Widget _child;
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
                child: SpinKitCircle(
                  color: CupertinoColors.black,
                  size: 250.0,
                )),
          )),
      Flexible(flex: 1, child: Center(child: Text("Is location turned on?"))),
    ]);
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      _child = mapWidget();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  /*Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("Me"),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Me"),
      ),
    ].toSet();
  }
*/

  Widget mapWidget() {
    return GoogleMap(
      indoorViewEnabled: true,
      mapType: MapType.terrain,
      buildingsEnabled: true,
      compassEnabled: true,
      //    markers: _createMarker(),
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
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          brightness: Brightness.light,
        ),
        home: Scaffold(
          key: _scaffoldKey,
          drawer: new Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text("drawer  head hahahah"),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text("Item 1"),
                ),
                ListTile(
                  title: Text("Item 2"),
                ),
                ListTile(
                  title: Text("Item 3"),
                ),
                ListTile(
                  title: Text("Item 4"),
                ),
                ListTile(
                  title: Text("Item 5"),
                ),
                ListTile(
                  title: Text("Item 6"),
                ),

              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
          bottomNavigationBar: CupertinoTabBar(
            currentIndex: 0, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new IconButton(
                    icon: Icon(
                  Icons.book,
                )),
                title: new Text('Get'),
              ),
              BottomNavigationBarItem(
                icon: new IconButton(
                  icon: Icon(Icons.question_answer),
                  onPressed: () {},
                ),
                title: new Text('Requests'),
              ),
            ],
          ),
          body: Stack(
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
                          backgroundColor: Colors.deepPurple,
                          child: Text('ME'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
      ),
    );
  }
}
