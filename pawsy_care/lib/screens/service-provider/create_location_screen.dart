import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/pawsy_location.dart';
import 'package:pawsy_care/widgets/shared/map_widget.dart';

class CreateLocationScreen extends StatefulWidget {
  const CreateLocationScreen({super.key});

  @override
  State<CreateLocationScreen> createState() => _CreateLocationScreenState();
}

class _CreateLocationScreenState extends State<CreateLocationScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController nameController = TextEditingController();
  LatLng _location = const LatLng(0, 0);

  void onMapTap(LatLng latLng) {
    _location = latLng;
  }

  void saveLocation() {
    PawsyLocation location = PawsyLocation(
        userId: _firestoreService.getCurrentUserID(),
        name: nameController.text,
        latitude: _location.latitude,
        longitude: _location.longitude);
    _firestoreService.createLocation(location);
    Navigator.pushReplacementNamed(context, '/create-service');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(
          locations: const [],
          hasMapTap: true,
          mapTap: (latLng) {
            onMapTap(latLng);
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              width: 200, // Set your desired width here
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                saveLocation();
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }
}
