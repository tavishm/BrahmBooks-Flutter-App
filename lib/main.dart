import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'dart:async';
import 'package:geolocation/geolocation.dart';
import 'dart:developer';
import 'utils.dart';
import 'initial-screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'initial-screen.dart';

final myControlfedback = TextEditingController();
final myControlhelp = TextEditingController();
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

LatLng _center = LatLng(71.43, 56.43);
Widget _child;
Set<Marker> markers;

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
      home: MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  @override
  Widget build(context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            key: _scaffoldKey,
            drawer: new Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                      height: 300,
                      child: DrawerHeader(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60, bottom: 30),
                          child: CircleAvatar(
                            backgroundColor: CupertinoColors.white,
                            child: Text('AM',
                                style: TextStyle(
                                    height: 1,
                                    fontSize: 50,
                                    color: CupertinoColors.black)),
                            /*  onPressed: () {Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => profile()),)}*/
                          ),
                        ),
                        decoration: BoxDecoration(
                          //color: Colors.black12,
                          gradient: LinearGradient(colors: [
                            CupertinoColors.activeBlue,
                            Colors.blue[400],
                          ]),
                        ),
                      )),
                  ListTile(
                    title: Text("Item 1"),
                  ),
                  ListTile(
                      title: Text("Help"),
                      onTap: () {
                        log("hola");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => profile()),
                        );
                      }),
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
                  ListTile(
                    title: Text("Item 7"),
                  ),
                  ListTile(
                    title: Text("Item 8"),
                  ),
                  ListTile(
                    title: Text("Item 9"),
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
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0, // this will be set when a new tab is tapped
              items: [
                BottomNavigationBarItem(
                  title: IconButton(
                    icon: Icon(Icons.question_answer),
                    onPressed: () {},
                    tooltip: "requests",
                  ),
                  icon: IconButton(tooltip: "Get", icon: Icon(Icons.book)),
                ),
                BottomNavigationBarItem(
                    title: IconButton(
                      icon: Icon(Icons.question_answer),
                      onPressed: () {},
                      tooltip: "requests",
                    ),
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
                                  child: Text('AM'),
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
  }
}

class help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: CupertinoNavigationBar(middle: Text("Help")),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: TextField(
                controller: myControlhelp,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.display1,
                decoration: InputDecoration(
                  labelText: 'what is your problem?',
                  labelStyle: Theme.of(context).textTheme.display1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          RaisedButton(child: Text("Send!!!")),
        ],
      ),
    ));
  }
}

class feedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: TextField(
                  controller: myControlfedback,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.display1,
                  decoration: InputDecoration(
                    labelText: 'feedback',
                    labelStyle: Theme.of(context).textTheme.display1,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            RaisedButton(child: Text("Send!!!!")),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear))];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //final suggestionList = query.isEmpty?popular_booksfetchpost():nearby_alphabetic_books();
    return FutureBuilder(
      future: get_feed_currently_search(query),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.done) {
          log(projectSnap.data.toString());
          if (projectSnap.hasError) {
            throw (projectSnap.error);
            showtoast(
                "an error occoured. Please report it to tavish.mankash@gmail.com");
            return Center(child: CupertinoActivityIndicator());
          } else {
            return GridView.builder(
                itemCount: projectSnap.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemBuilder: (context, index) => Card(
                        child: Column(children: <Widget>[
                      Text(projectSnap.data[index].toString()),
                      //Image.network(projectSnap.data[index]['image'])
                    ])));
          }
        }
        return Center(child: CupertinoActivityIndicator());
      },
    );

/*

    ))*/
  }
}

class profile extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(),
      body: Column(
        children: <Widget>[
          Center(
              child: CircleAvatar(
            backgroundColor: CupertinoColors.activeBlue,
            child: Text('AM',
                style: TextStyle(
                    height: 2, fontSize: 10, color: CupertinoColors.black)),
          )),
          Container(
              margin: const EdgeInsets.all(10),
              //child: Text("Abhimanyu Mankash"),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Name *',
                  labelText: 'Abhimanyu Mankash',
                ),
                /*   onSaved: (String value) {

                  },*/
              ))
        ],
      ),
    );
  }
}
