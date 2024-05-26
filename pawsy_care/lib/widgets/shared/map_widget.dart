import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pawsy_care/models/pawsy_location.dart';

class MapWidget extends StatefulWidget {
  final List<PawsyLocation> locations;
  final bool hasMapTap;
  final Function(LatLng) mapTap;

  const MapWidget(
      {required this.locations,
      required this.hasMapTap,
      required this.mapTap,
      super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  bool userLocationLoaded = false;

  Location locationController = Location();

  LatLng? currentLocation;

  Marker? currentLocationMarker;

  static const LatLng _cameraPosition =
      LatLng(41.991073882055744, 21.445443777271347);

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
    initMarkers();
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocation != null) {
      markers.add(Marker(
          markerId: const MarkerId("initialPosition"),
          position: currentLocation!,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      return GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: _onMapTapped,
        initialCameraPosition:
            const CameraPosition(target: _cameraPosition, zoom: 15),
        markers: markers,
      );
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<void> cametaToPosition(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 15)));
  }

  void _onMapTapped(LatLng position) {
    if (!widget.hasMapTap) {
      return;
    }

    setState(() {
      markers.removeWhere((element) => element.markerId.value == "mapTap");

      markers.add(Marker(
          markerId: const MarkerId("mapTap"),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueOrange)));
    });

    widget.mapTap(position);
  }

  void initMarkers() {
    for (PawsyLocation location in widget.locations) {
      markers.add(Marker(
          markerId: MarkerId(location.name),
          position: LatLng(location.latitude, location.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueOrange)));
    }
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();

    if (!serviceEnabled) {
      return;
    }

    serviceEnabled = await locationController.requestService();

    permissionGranted = await locationController.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationController.onLocationChanged.listen((LocationData currentLocation) {
      updateCurrentLocation(currentLocation);
    });
  }

  void updateCurrentLocation(LocationData currentLocation) {
    if (currentLocation.latitude == null || currentLocation.longitude == null) {
      return;
    }

    if (!userLocationLoaded) {
      setState(() {
        this.currentLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        userLocationLoaded = true;
        cametaToPosition(this.currentLocation!);
      });
    }
  }
}
