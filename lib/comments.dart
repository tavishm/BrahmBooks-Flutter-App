//  proflie comments
/*class profile extends StatelessWidget {
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
}*/
//   help comments
/*class help extends StatelessWidget {
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
*/
//   feedback comments
/*
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
}*/
//marker comments
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
// otp comments
/*class otp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text("Brahm Books"),
          trailing: IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => about()),
              );
            },
          ),
        ),
        body: Scaffold(
          appBar: CupertinoNavigationBar(middle: Text("Verify OTP")),
          body: Column(
            children: <Widget>[
              Text('verify your otp'),
              Center(
                  child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: '__ __ __ __ __ __'),
              )),
              CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: Text("verify!"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  })
            ],
          ),
        ));
  }                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (myControlname.text == ""){
                        log(myControlname.text);
                        Fluttertoast.showToast(msg: "Please mention your name",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Future<http.Response> fetchPost2() async {
                          //<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts])
                          log('brahm.ai/brahm/brahm_books/signup_api.py?phone=' +
                                  myControlph.text + '&name=' +
                                  myControlname.text + '&deviceuid=' +
                                  read_uid());
                          var response = await http

}
*/