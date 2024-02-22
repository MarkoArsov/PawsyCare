import 'package:flutter/material.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/pawsy_location.dart';
import 'package:pawsy_care/widgets/shared/map_widget.dart';

class ServiceProviderMapScreen extends StatefulWidget {
  const ServiceProviderMapScreen({super.key});

  @override
  State<ServiceProviderMapScreen> createState() =>
      _ServiceProviderMapScreenState();
}

class _ServiceProviderMapScreenState extends State<ServiceProviderMapScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  late List<PawsyLocation> locations = [];

  var isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    String userId = _firestoreService.getCurrentUserID();
    List<PawsyLocation> userLocations =
        await _firestoreService.getLocationsByUser(userId);
    setState(() {
      locations.addAll(userLocations);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : MapWidget(
              locations: locations, hasMapTap: false, mapTap: (latLng) {}),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/service-list');
        },
        backgroundColor: Colors.white, 
        child: const Icon(Icons.list),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacementNamed(
                context, '/service-provider-calendar');
          }
        },
      ),
    );
  }
}
