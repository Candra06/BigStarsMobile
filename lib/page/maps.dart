import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({Key key}) : super(key: key);

  @override
  _GoogleMapsViewState createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  final Set<Marker> _markers = {};
  final LatLng _currentPosition = LatLng(-7.9169857, 113.8168929);

  @override
  void initState() {
    _markers.add(
      Marker(
        markerId: MarkerId("3.595196, 98.672226"),
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
      ),
      body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: 14.0,
          ),
          markers: _markers,
          onTap: (position) {
            setState(() {
              _markers.add(
                Marker(
                  markerId: MarkerId("${position.latitude}, ${position.longitude}"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: position,
                ),
              );
            });
          }),
    );
  }
}
