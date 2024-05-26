import 'package:flutter/material.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/pawsy_location.dart';
import 'package:pawsy_care/models/service.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});

  @override
  CreateServiceScreenState createState() => CreateServiceScreenState();
}

class CreateServiceScreenState extends State<CreateServiceScreen> {
  final List<PawsyLocation> locations = [];
  PawsyLocation _selectedLocation =
      PawsyLocation(userId: "", name: "", latitude: 0, longitude: 0);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();

  void addService(Service service) {
    _firestoreService.createService(service);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/service-provider');
  }

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
      if (locations.isNotEmpty) {
        _selectedLocation = locations[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Pawsy Care',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                value: _selectedLocation.name,
                items: locations.map((location) {
                  return DropdownMenuItem(
                    value: location.name,
                    child: Text(location.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = locations
                        .firstWhere((element) => element.name == value);
                  });
                },
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Service Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter service name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 3,
                controller: descriptionController,
                decoration:
                    const InputDecoration(labelText: "Service Description"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  suffixText: '€',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter service price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _navigateToCreateLocation(context);
                },
                child: const Text('Add new location'),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Service service = Service(
                    userId: _firestoreService.getCurrentUserID(),
                    location: _selectedLocation,
                    name: nameController.text,
                    description: descriptionController.text,
                    price: double.parse(priceController.text),
                  );
                  addService(service);
                },
                child: const Text('Add Service'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCreateLocation(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/create-location');
  }
}
