import 'package:flutter/material.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/pawsy_location.dart';
import 'package:pawsy_care/widgets/shared/map_widget.dart';

class PetOwnerMapScreen extends StatefulWidget {
  const PetOwnerMapScreen({super.key});

  @override
  State<PetOwnerMapScreen> createState() => _PetOwnerMapScreenState();
}

class _PetOwnerMapScreenState extends State<PetOwnerMapScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  late List<PawsyLocation> locations = [];

  var isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    List<PawsyLocation> allLocations =
        await _firestoreService.getAllLocations();
    setState(() {
      locations.addAll(allLocations);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : MapWidget(
                locations: locations, hasMapTap: false, mapTap: (latLng) {}));
  }
}
