import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'dart:async';
import 'package:geolocation/geolocation.dart';
import 'dart:developer';
//import 'utils.dart';
import 'initial-screen.dart';




void main(){
    runApp(MyApp());
  }
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
LatLng _center = LatLng(1, 1);
class _MyAppState extends State<MyApp> {

  LocationResult locations = null;
  StreamSubscription<LocationResult> streamSubscription;
  bool trackLocation = false;
//bhaiya, maza nahi aara, let's do voice call        after lunch. parth bhaiya, lunch break?
//continue  n 1:35.you avaiable then?
//yes.great.bye            bye   i am going                            yeah ok
  @override
  initState() {
    super.initState();
   // if (checkGps()) {
      trackLocation = false;
      locations = null;
      //log(getLocations()[0].toString());
      while (true){
        _center = getLocations();
        if (_center != null){
          break;
        }
        log("center obj: " + _center.toString());
  //    }
    }
  }

  dynamic getLocations() {
    if (trackLocation) {
      setState(() => trackLocation = false);
      streamSubscription.cancel();
      streamSubscription = null;
      locations = null;
    } else {
      log("success!!!!");
      setState(() => trackLocation = true);

      streamSubscription = Geolocation.locationUpdates(
        accuracy: LocationAccuracy.best,
        displacementFilter: 0.0,
        inBackground: false,
      ).listen((result) {
        final location = result;
        setState(() {
          locations = location;
        });
        log(location.location.latitude.toString());
        log(location.location.longitude.toString());
        return LatLng(location.location.latitude, location.location.longitude);
      });

      streamSubscription.onDone(() =>
          setState(() {
            trackLocation = false;
          }));
    }
  }


  GoogleMapController mapController;


// you have used google maps API? Kanha? yes we have used google's a
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        home: Scaffold(
          // bottomNavigationBar: BottomAppBar(
          // color: Colors.white,

          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
          bottomNavigationBar: BottomNavigationBar(
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
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11,
                  ),
                ),
              ),

              Positioned(
                top: 40,
                right: 15,
                left: 15,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
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
      //    ]),
      //     child: bottomAppBarContents,

      //       floatingActionButton: FloatingActionButton(onPressed: null),
    );
  }
}

checkGps() async {
  final GeolocationResult result = await Geolocation.isLocationOperational();
  if (result.isSuccessful) {
    return true;
  } else {
    return false;
  }
}
class help extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(appBar: AppBar(),),);
  }
}
