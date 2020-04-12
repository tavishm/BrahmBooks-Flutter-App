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




void main(){
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
    _child = Center(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: CupertinoColors.white,
            child: SpinKitChasingDots(
      color: CupertinoColors.activeGreen,
      size: 250.0,
        )));
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


  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("Me"),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(80),
        infoWindow: InfoWindow(title: "Me"),
      ),
    ].toSet();
  }


  Widget mapWidget(){
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16,
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
        home: Scaffold(

          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                          child: IconButton(icon: Icon(Icons.menu),
                            onPressed: (){},),
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
                          child: Text('AM'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

class help extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(appBar: AppBar(),),);
  }
}