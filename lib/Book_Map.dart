import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "utils.dart";

void main() {
  runApp(BookMap());
}

class BookMap extends StatelessWidget {
  var infostuff;
  BookMap({Key key, @required this.infostuff}) : super(key: key);
  GoogleMapController mapController;

  void _onMapCreatedinfo(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
        middle: Text(
        infostuff["bookname"],
    )),
    body: GoogleMap(
      indoorViewEnabled: true,
      mapType: MapType.terrain,
      buildingsEnabled: true,
      compassEnabled: true,
      markers: [
        Marker(
          markerId: MarkerId(infostuff["bookname"]),
          position: LatLng(infostuff["distances"][0]["lng"],
              infostuff["distances"][0]["lng"]),
          //  position: LatLng(0,0),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: "Me"),
        )
      ].toSet(),
      onMapCreated: _onMapCreatedinfo,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(
            infostuff["distances"][0]["lat"], infostuff["distances"][0]["lng"]),
        zoom: 14,
      ),
    )
    );
  }
}
