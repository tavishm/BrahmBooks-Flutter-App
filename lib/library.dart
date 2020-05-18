import 'package:flutter/material.dart';
import 'dart:io' as Io;
//import 'package:image/image.dart';

void main() {
  runApp(myLibrary());
}

class myLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("my library"),
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: Card(
                  child: Row(
                    children: <Widget> [
                 /*Image image = decodeImage(new Io.File('test.jpg').readAsBytesSync());

            // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
            Image thumbnail = copyResize(image, width: 120);

          // Save the thumbnail as a PNG.
          new Io.File('out/thumbnail-test.png')
        ..writeAsBytesSync(encodePng(thumbnail));*/
                    Image.network('http://ecx.images-amazon.com/images/I/512O7wP2d%2BL.jpg'),
                      Column(children: <Widget> [
                        Text("Travels in the Greater Yellowstone"),
                        Text("Jack Turner")
                      ])
                  ]
                )
                )),
          ],
        ),
      ),
    );
  }
}
