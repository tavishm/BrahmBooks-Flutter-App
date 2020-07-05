import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import "package:flutter/cupertino.dart";
import "utils.dart";
import "dart:developer";

//void main() => runApp(ConversationView());
String conversation_status;

class ConversationView extends StatefulWidget {
  var infostuff;
  ConversationView({Key key, @required this.infostuff}) : super(key: key);
  @override
  _ConversationViewState createState() => _ConversationViewState(infostuff);
}

class _ConversationViewState extends State<ConversationView> {
  //Widget conversationview;
  var infostuff;
  _ConversationViewState(this.infostuff);
  Widget conversationview = Center(child: CupertinoActivityIndicator());
  @override
  void initState() {
    log(infostuff["interprimeid"].toString());
    action_function();
    super.initState();
  }

  action_function() async {
    conversation_status =
        await interprimeinfofetchpost(infostuff["interprimeid"].toString());
    log(conversation_status);
    if (conversation_status == "11") {
      setState(() {
        print(conversationview);
        conversationview = Center(
            child: Card(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      Image.network(infostuff["image"]),
                    Container(
                        margin: const EdgeInsets.all(5),
                        child:Text(
                        "We are waiting for the book's ownder to respond back.",
                            style: TextStyle(fontSize: 25),

                            textAlign: TextAlign.center)
                    )]))));
        /*   conversationview =

          Column(children: [
            botbubble(Text("I'm waiting for the book owner to reply back.",
               // textAlign: TextAlign.left
            )),


              Flexible(
              child: Row(children: [
            ActionChip(
              onPressed: () {
               /* conversationview = ListView(children: [
                  botbubble(Text(
                      "I'm waiting for the book owner to reply back.",
                      textAlign: TextAlign.left)),
                  userbubble(Text("ok", textAlign: TextAlign.right))
                ]);*/
              },
              label: Text("ok"),
            )
          ])
            )]);*/
      });
    }
    if (conversation_status == "12") {
      setState( () {
        print( conversationview );
        conversationview = Center(child: Card(
              child: Container(
                margin: const EdgeInsets.all( 10 ),
                child: Column( children: [
                Container(
                margin: const EdgeInsets.all( 5 ),
                child: Text(
                    "Someone is interested in exchanging your ",
                    style: TextStyle( fontSize: 25 ),

                    textAlign: TextAlign.center ),
              ),

              Image.network( infostuff["image"] ),
              Container(
                  margin: const EdgeInsets.all( 5 ),
                  child: Text(
                      "What would you give it for?",
                      style: TextStyle( fontSize: 25 ),

                  textAlign: TextAlign.center ),
            ),
            ListView.builder(
              itemCount: infostuff["book1"].length,
              itemBuilder: (context, index) =>
                  GestureDetector(
                      onTap: () {
                        stagedactionsapi(1,1,interprimeid: infostuff["interprimeid"], interhelpid: infostuff["interhelpid"], book1: infostuff["bookid"]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only( top: 16 ),
                        child: Card(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black38, width: 0.5 ),
                                borderRadius: BorderRadius.circular( 20 ) ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20 ),
                            child: Image.network(
                                infostuff["book1"][index]["image"] )

                        ),
                      ) ),
              //Card(children: <Widget> [ Text(),])
            ),
            CupertinoButton( child: Text( "Not interested" ) , onPressed :() {stagedactionsapi(1,2,interprimeid: infostuff["interprimeid"], interhelpid: infostuff["interhelpid"]);},)
            ] ) ) )
            );
      } );
    }    if (conversation_status == "21") {
      setState(() {
        log("21");
        print(conversationview);
        conversationview = Center(
            child: Card(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: ListView(children: [
                      Container(
                          margin: const EdgeInsets.all(5),
                          child:Text(
                              "Do you want to exchange ",
                              style: TextStyle(fontSize: 25),

                              textAlign: TextAlign.center)
                      ),
                      Image.network(infostuff["book1"][0]["image"]),
                      Container(
                          margin: const EdgeInsets.all(15),
                          child:Text(
                              " for ",
                              style: TextStyle(fontSize: 25),

                              textAlign: TextAlign.center)
                      ),
                      Image.network(infostuff["image"]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        CupertinoButton(child: Text("Accept"),
                        onPressed:(){
                          stagedactionsapi(2,1,interprimeid: infostuff["interprimeid"], interhelpid: infostuff["interhelpid"]);
                        }
                        ),
                        CupertinoButton(child: Text("Decline"),
                            onPressed:(){
                              stagedactionsapi(2,2,interprimeid: infostuff["interprimeid"]);
                            }),
                      ])
                    ]))));
      });
    }
    if (conversation_status == "22") {
      setState(() {
        print(conversationview);
        conversationview = Center(
            child: Card(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      Image.network(infostuff["image"]),
                      Container(
                          margin: const EdgeInsets.all(5),
                          child:Text(
                              "We are confirming if "+infostuff["book1"]+"'s owner is willing to exchange. Please wait",
                              style: TextStyle(fontSize: 25),

                              textAlign: TextAlign.center)
                      )]))));
      });
    }
    if (conversation_status == "31") {
      setState(() {
        print(conversationview);
        conversationview = Center(
            child: Card(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      Image.network(infostuff["image"]),
                      Container(
                          margin: const EdgeInsets.all(5),
                          child:Text(
                              infostuff["book2"]+"'s owner rejected your request to exchange, asking other's around you if they can exchange.",
                              style: TextStyle(fontSize: 25),

                              textAlign: TextAlign.center)
                      )]))));
      });
    }
    if (conversation_status == "32") { setState( () {
        print( conversationview );
        conversationview = Center(
            child: ListView(children: [Card(
              child: Container(
                margin: const EdgeInsets.all( 10 ),
                child: ListView( children: [
                Container(
                margin: const EdgeInsets.all( 5 ),
                child: Text(
                    "Someone is interested in exchanging your ",
                    style: TextStyle( fontSize: 25 ),

                    textAlign: TextAlign.center ),
              ),

              Image.network( infostuff["image"] ),
              Container(
                  margin: const EdgeInsets.all( 5 ),
                  child: Text(
                      "What would you give it for?",
                      style: TextStyle( fontSize: 25 ),

                  textAlign: TextAlign.center ),
            ),
            ListView.builder(
              itemCount: infostuff["book1"].length,
              itemBuilder: (context, index) =>
                  GestureDetector(
                      onTap: () { stagedactionsapi(3,1,interprimeid: infostuff["interprimeid"], interhelpid: infostuff["interhelpid"], book1: infostuff["bookid"]);},
                      child: Padding(
                        padding: const EdgeInsets.only( top: 16 ),
                        child: Card(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black38, width: 0.5 ),
                                borderRadius: BorderRadius.circular( 20 ) ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20 ),
                            child: Image.network(
                                infostuff["book1"][index]["image"] )

                        ),
                      ) ),
              //Card(children: <Widget> [ Text(),])
            ),
            CupertinoButton( child: Text( "Not interested" ), onPressed :() {stagedactionsapi(3,2,interprimeid: infostuff["interprimeid"], interhelpid: infostuff["interhelpid"]);},
)
            ] ) ) )
            ]));
      } );}
    if (conversation_status == "41") {
      setState(() {
        print(conversationview);
        conversationview = Center(
            child: Card(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      Image.network(infostuff["image"]),
                      Container(
                          margin: const EdgeInsets.all(5),
                          child:Text(
                              "This book couldn't be exchanged",
                              style: TextStyle(fontSize: 25),

                              textAlign: TextAlign.center)
                      )]))));
      });
    }
    if (conversation_status == "42") {
      setState(() {
        print(conversationview);
        conversationview = Center(
            child: Card(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      Image.network(infostuff["image"]),
                      Container(
                          margin: const EdgeInsets.all(5),
                          child:Text(
                              "This book couldn't be exchanged",
                              style: TextStyle(fontSize: 25),

                              textAlign: TextAlign.center)
                      )]))));
      });
    }
    if (conversation_status == "51") {
      setState(() {
        print(conversationview);
        conversationview = Center(
            child: Card(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      Container(
                          margin: const EdgeInsets.all(5),
                          child:Text(
                              "do you want to exchange?",
                              style: TextStyle(fontSize: 25),

                              textAlign: TextAlign.center)

                      ),
                      Image.network(infostuff["image"]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CupertinoButton(child: Text("Accept"),
                                onPressed:(){
                                  stagedactionsapi(5,1,interprimeid: infostuff["interprimeid"]);
                                }
                            ),
                            CupertinoButton(child: Text("Decline"),
                                onPressed:(){
                                  stagedactionsapi(5,2,interprimeid: infostuff["interprimeid"]);
                                }),
                            CupertinoButton(child: Text("have to"),
                                onPressed:(){
                                 // stagedactionsapi(2,2,interprimeid: infostuff["interprimeid"]);
                                }),

                          ])
                    ]))));
      });
    }
    if (conversation_status == "52") { setState(() {
      print(conversationview);
      conversationview = Center(
          child: Card(
              child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(children: [
                    Container(
                        margin: const EdgeInsets.all(5),
                        child:Text(
                            "do you want to exchange?",
                            style: TextStyle(fontSize: 25),

                            textAlign: TextAlign.center)

                    ),
                    Image.network(infostuff["image"]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(child: Text("Accept"),
                              onPressed:(){
                                stagedactionsapi(5,1,interprimeid: infostuff["interprimeid"]);
                              }
                          ),
                          CupertinoButton(child: Text("Decline"),
                              onPressed:(){
                                stagedactionsapi(5,2,interprimeid: infostuff["interprimeid"]);
                              }),
                          CupertinoButton(child: Text("have to"),
                              onPressed:(){
                                // stagedactionsapi(2,2,interprimeid: infostuff["interprimeid"]);
                              }),

                        ])
                  ]))));
    });
    }
    if (conversation_status == "61") {
      setState(() {
        print(conversationview);
        conversationview = Center(
            child: Card(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      Image.network(infostuff["image"]),
                      Container(
                          margin: const EdgeInsets.all(5),
                          child:Text(
                              "This book has been exchanged, if not please report this to mankash.abhimanyu@gmail.com",
                              style: TextStyle(fontSize: 25),

                              textAlign: TextAlign.center)
                      )]))));
      });
    }
    if (conversation_status == "62") {
      setState(() {
        print(conversationview);
        conversationview = Center(
            child: Card(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      Image.network(infostuff["image"]),
                      Container(
                          margin: const EdgeInsets.all(5),
                          child:Text(
                              "This book has been exchanged, if not please report this to mankash.abhimanyu@gmail.com",
                              style: TextStyle(fontSize: 25),

                              textAlign: TextAlign.center)
                      )]))));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: CupertinoNavigationBar(
              middle: Text(infostuff["show"]),
            ),
            body:
                conversationview /*ListView(children: <Widget>[
            Bubble(
                margin: BubbleEdges.only(top: 10),
                alignment: Alignment.topRight,
                nipWidth: 8,
                nipHeight: 24,
                nip: BubbleNip.rightTop,
                color: Color.fromRGBO(225, 255, 199, 1.0),
                child: Column(children: <Widget>[
                  Text("hello World!!!", textAlign: TextAlign.right),
                  Image.network(
                      "http://ecx.images-amazon.com/images/I/41RX7hoxFXL.jpg"),
                ])),
          ])),*/
            );
  }
}
