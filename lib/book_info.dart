import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "utils.dart";
import 'Book_Map.dart';

void main() {
  runApp(BookInfo());
}

class BookInfo extends StatelessWidget {
  var infostuff;
  BookInfo({Key key, @required this.infostuff}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
            middle: Text(
          infostuff["bookname"],
        ),
            trailing: IconButton(icon: Icon(Icons.map), onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (BookMap(infostuff: infostuff))),
              );
            })
        ),
        body: // ListView(children: <Widget>[
            Column(children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10),
              child: Flexible(
                flex: 2,
                child: Image.network(
                  infostuff["image"],

                  //  )
                ),
              )),
          Container(
              margin: const EdgeInsets.all(10),
              child: Flexible(
                flex: 1,
                child: Text(
                  "author - " + infostuff["author"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              )),

          Container(
              margin: const EdgeInsets.all(10),
              child: Flexible(
                flex: 1,
                child: Text(
                  "distance - " +
                      infostuff["distances"][0]['distance'].toInt().toString() +
                      " metres",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              )),
        ]),
        floatingActionButton: //Row(children: [
          FloatingActionButton.extended(
            onPressed: () {
              // Add your onPressed code here!
            },
            label: Text('exchange'),
            icon: Icon(Icons.question_answer),
            backgroundColor: Colors.lightGreen,
          ),
       /*FloatingActionButton.extended(
            onPressed: () {
              // Add your onPressed code here!
            },
            label: Text('map view'),
            icon: Icon(Icons.map),
            backgroundColor: Colors.lightGreen,
          )*/
   //     ]),
      //),
    );
  }
}
