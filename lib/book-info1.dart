import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "utils.dart";
import  "dart:developer";

void main() {
  runApp(BookInfo1());
}

class BookInfo1 extends StatelessWidget {
  var infostuff;
  BookInfo1({Key key, @required this.infostuff}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
            middle: Text(
          infostuff["bookname"],
        ),
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

        ]),
        floatingActionButton: //Row(children: [
          FloatingActionButton.extended(
            onPressed: () {
              log("first post");
              add_book_to_library(infostuff["bookid"]);
              showtoast("the book has been added to your library "
                  "please check it by going to your library "
                  "if you encounter any problems please report it "
                  "to mankash.abhimanyu@gmail.com");
            },
            label: Text('add book to library'),
            icon: Icon(Icons.add),
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
