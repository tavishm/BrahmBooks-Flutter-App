import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:developer';
import 'book-info1.dart';
import 'request.dart';
import 'utils.dart';
import 'initial-screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'account.dart';
import 'initial-screen.dart';
import "library.dart";
import "help.dart";
import "feedback.dart";
import "conversation.dart";
import "book_info.dart";
final myControlfedback = TextEditingController();
final myControlhelp = TextEditingController();
void main() {
  runApp(MyApp());
}

var firstdigs_main = "";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

LatLng _center = LatLng(71.43, 56.43);
Widget _child;

Set<Marker> markers;
int _selectedIndex = 0;

class _MyAppState extends State<MyApp> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
    firsttwolettersofname();
    getCurrentLocation(context);
  }

  void getCurrentLocation(scontext) async {
    var name = await read_name();
    if (name == ""){
      getnamefetchpost();
    }
    var deviceuid = await read_deviceuid();
    if (deviceuid=="0"){
      runApp(TyApp());
    }
    Position res = await Geolocator().getCurrentPosition();
    log("post res");
    save_latlng(res.latitude, res.longitude);
    markers = await mapfetchpost(res.latitude, res.longitude, scontext);
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

  Widget widgetoptions(context, count) {
    List<Widget> _widgetOptions = <Widget>[
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
                        showSearch(context: context, delegate: SearchPage());
                      },
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
      FutureBuilder(
          future: easyrequestpagefetchpost(),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.done) {
              if (projectSnap.hasError) {
                throw (projectSnap.error);
                showtoast(
                    "an error occoured. Please report it to tavish.mankash@gmail.com");
                return Center(child: CupertinoActivityIndicator());
              } else {
                log("I have come here conv");
                return ListView.builder(
                  itemCount: projectSnap.data.length,
                    itemBuilder: (context, index) =>
                        GestureDetector(
                          onTap: () {
                            log(projectSnap.data[index]["interprimeid"].toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (ConversationView(
                                      infostuff: projectSnap.data[index]))),
                            );
                          },
                          child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Card(

                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black38, width: 0.5),
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListTile(
                              leading: CircleAvatar(backgroundImage: NetworkImage(projectSnap.data[index]["image"])),
                              title: Text(
                                projectSnap.data[index]["show"],
                                style: Theme.of(context).textTheme.body1,
                              ),
                              subtitle: Text( projectSnap.data[index]["author"],
                                style: TextStyle(height: 1, fontSize: 10),))
                          ),
                        )),
                        //Card(children: <Widget> [ Text(),])
                );
              }
            }
            return Center(child: CupertinoActivityIndicator());
          }),
    ];
    return _widgetOptions.elementAt(count);
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
      home: Builder(
          builder: (context) => Scaffold(
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
                              // onPressed: () {},

                              child: Text(firstdigs_main,
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
                        title: Text("Help"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => help()),
                          );
                        }),
                    ListTile(
                        title: Text("feedback"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => feedback()),
                          );
                        }),
                    ListTile(
                        title: Text("my library"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => mylibrary()),
                          );
                        }),
                    ListTile(
                        title: Text("my account"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => profile()),
                          );
                        }),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  showSearch(context: context, delegate: SearchPage132());
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.amber[800],
                  onTap: _onItemTapped,
                  items: [
                    BottomNavigationBarItem(
                      title: Text("Explore"),
                      icon: IconButton(tooltip: "Get", icon: Icon(Icons.book)),
                    ),
                    BottomNavigationBarItem(
                        title: Text("Requests"),
                        icon: IconButton(
                          icon: Icon(Icons.question_answer),
                          /*  onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Request()),
                    );},*/
                          tooltip: "requests",
                        )),
                  ]),
              body: widgetoptions(context, _selectedIndex))),
    );
  }
}

class SearchPage extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        FocusScope.of(context).unfocus();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: get_feed_currently_search(query),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.done) {
          if (projectSnap.hasError) {
            //throw (projectSnap.error);
            showtoast(
                "an error occoured. Please report it to tavish.mankash@gmail.com");
            return Center(child: CupertinoActivityIndicator());
          } else {
            log("I have come here");
            return GridView.builder(
                itemCount: projectSnap.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 0.5,
                ),
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => (BookInfo1())),
                      );
                    },
                    child: Card(
                        child: Column(children: <Widget>[
                      //Text(projectSnap.data[index]["image"]),
                      //   RaisedButton(onPressed: (){
                      //   log(projectSnap.data[index].keys.toList()[2].toString());
                      // }),
                      Image.network(
                        projectSnap.data[index]['image'],
                      ),
                      // Text(projectSnap.data[index]['bookname']) ,
                      //     Text(projectSnap.data[index]['author']),
                      Row(children: <Widget>[
                        Center(
                            child: Text(projectSnap.data[index]['distances'][0]
                                        ['distance']
                                    .toString() +
                                " meters"))
                      ]),
                      Row(children: <Widget>[
                        Center(
                            child: Text(projectSnap
                                    .data[index]["distances"].length
                                    .toString() +
                                " available"))
                      ]),
                    ]))));
          }
        }
        return Center(child: CupertinoActivityIndicator());
      },
    );

/*

    ))*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //final suggestionList = query.isEmpty?popular_booksfetchpost():nearby_alphabetic_books();
    return FutureBuilder(
      future: get_feed_currently_search(query),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.done) {
          if (projectSnap.hasError) {
            //throw (projectSnap.error);
            showtoast(
                "an error occoured. Please report it to tavish.mankash@gmail.com");
            return Center(child: CupertinoActivityIndicator());
          } else {
            log("I have come here");
            return GridView.builder(
                itemCount: projectSnap.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 0.5,
                ),
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookInfo(
                                  infostuff: projectSnap.data[index],
                                )),
                      );
                    },
                    child: Card(
                        child: Column(children: <Widget>[
                      //Text(projectSnap.data[index]["image"]),
                      //   RaisedButton(onPressed: (){
                      //   log(projectSnap.data[index].keys.toList()[2].toString());
                      // }),
                      Image.network(
                        projectSnap.data[index]['image'],
                      ),
                      // Text(projectSnap.data[index]['bookname']) ,
                      //     Text(projectSnap.data[index]['author']),
                      Row(children: <Widget>[
                        Center(
                            child: Text(projectSnap.data[index]['distances'][0]
                                        ['distance']
                                    .toString() +
                                " meters"))
                      ]),
                      Row(children: <Widget>[
                        Center(
                            /* child: Text(projectSnap
                                    .data[index]["distances"].length
                                    .toString() +
                                " available")*/
                            ),
                      ]),
                    ]))));
          }
        }
        return Center(child: CupertinoActivityIndicator());
      },
    );

/*

    ))*/
  }
}

class mylibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(middle: Text("My Library")),
        body: FutureBuilder(
            future: mylibraryfetchpost(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  throw (snapshot.error);
                  showtoast(
                      "an error occoured. Please report it to tavish.mankash@gmail.com");
                  return Center(child: CupertinoActivityIndicator());
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => Container(
                          width: double.infinity,
                          height: 150,
                          child: Card(
                              child: Row(children: <Widget>[
                            Image.network(snapshot.data[index]["image"],
                                height: double.ivysnfinity),
                            Column(children: [
                              Center(
                                  child: Column(children: [
                                Text(snapshot.data[index]["bookname"]),
                                Text(snapshot.data[index]["author"])
                              ]))
                            ])
                          ]))));
                }
              }
              return Center(child: CupertinoActivityIndicator());
            }));
  }
}

class SearchPage132 extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        FocusScope.of(context).unfocus();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: get_alphabetic_books(query),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.done) {
          if (projectSnap.hasError) {
            //throw (projectSnap.error);
            showtoast(
                "an error occoured. Please report it to tavish.mankash@gmail.com");
            return Center(child: CupertinoActivityIndicator());
          } else {
            log("I have come here");
            return GridView.builder(
                itemCount: projectSnap.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 0.5,
                ),
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (BookInfo1(
                                infostuff: projectSnap.data[index]))),
                      );
                    },
                    child: Card(
                        child: Column(children: <Widget>[
                      //Text(projectSnap.data[index]["image"]),
                      //   RaisedButton(onPressed: (){
                      //   log(projectSnap.data[index].keys.toList()[2].toString());
                      // }),
                      Image.network(
                        projectSnap.data[index]['image'],
                      ),
                      // Text(projectSnap.data[index]['bookname']) ,
                      //     Text(projectSnap.data[index]['author']),
                    ]))));
          }
        }
        return Center(child: CupertinoActivityIndicator());
      },
    );

/*

    ))*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //final suggestionList = query.isEmpty?popular_booksfetchpost():nearby_alphabetic_books();
    return FutureBuilder(
      future: get_alphabetic_books(query),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.done) {
          if (projectSnap.hasError) {
            throw (projectSnap.error);
            //  showtoast(
            //        "an error occoured. Please report it to tavish.mankash@gmail.com");
            return Center(child: CupertinoActivityIndicator());
          } else {
            log("I have come here");
            return GridView.builder(
                itemCount: projectSnap.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 0.5,
                ),
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookInfo1(
                                  infostuff: projectSnap.data[index],
                                )),
                      );
                    },
                    child: Card(
                        child: Column(children: <Widget>[
                      //Text(projectSnap.data[index]["image"]),
                      //   RaisedButton(onPressed: (){
                      //   log(projectSnap.data[index].keys.toList()[2].toString());
                      // }),
                      Image.network(
                        projectSnap.data[index]['image'],
                      ),
                      // Text(projectSnap.data[index]['bookname']) ,
                      //     Text(projectSnap.data[index]['author']),
                    ]))));
          }
        }
        return Center(child: CupertinoActivityIndicator());
      },
    );

/*

    ))*/
  }
}


