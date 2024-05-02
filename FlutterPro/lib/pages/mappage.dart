import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.686382, 85.315399),
    zoom: 16,
  );

  bool showmap = false;
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    showmapfunc();
    _loadMapStyle();
  }

  showmapfunc() {
    Future.delayed(Duration(seconds: 1)).whenComplete(() {
      setState(() {
        showmap = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, '/rent');
            },
          ),
        ),
        title: Text('Select Location'),
      ),
      body: Stack(
        children: [
          showmap
              ? GoogleMap(
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              if (_controller.isCompleted) {
                _controller.complete(controller);
                _loadMapStyle(); // Load and apply map style when the map is created
              }
            },
            onTap: (LatLng location) {
              setState(() {
                selectedLocation = location;
                print(selectedLocation);
              });
            },
            markers: Set<Marker>.from([
              if (selectedLocation != null)
                Marker(
                  markerId: MarkerId('selectedLocation'),
                  position: selectedLocation!,
                  infoWindow: InfoWindow(title: 'Selected Location'),
                ),
            ]),
          )
              : Container(
            child: Center(child: CircularProgressIndicator()),
          ),
          if (selectedLocation != null)
            Positioned(
              bottom: 30.0,
              left: 140.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedLocation);
                },
                child: Text("Choose Location"),
              ),
            ),
        ],
      ),
    );
  }

  var mapthemedata;

  Future<void> _loadMapStyle() async {
    final String mapStyleJson = await rootBundle.loadString('assets/raw/maptheme.json');
    final GoogleMapController controller = await _controller.future;

    // Check if controller is not null before applying the map style
    if (controller != null) {
      controller.setMapStyle(mapStyleJson);
    }
  }

}
