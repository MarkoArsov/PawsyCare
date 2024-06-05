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

  void addService(Service service) async {
    await _firestoreService.createService(service);
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
        body: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
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
                      decoration: InputDecoration(
                        labelText: 'Location',
                        labelStyle: const TextStyle(color: Color(0xFF4f6d7a)),
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide:
                              const BorderSide(color: Color(0xFF4f6d7a)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFF4f6d7a)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      _navigateToCreateLocation(context);
                    },
                    icon: const Icon(Icons.add, color: Color(0xFF4f6d7a)),
                    iconSize: 30,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Service Name',
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelStyle: const TextStyle(color: Color(0xFF4f6d7a)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: Color(0xFF4f6d7a)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF4f6d7a)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter service name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixText: '€',
                  labelStyle: const TextStyle(color: Color(0xFF4f6d7a)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: Color(0xFF4f6d7a)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF4f6d7a)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter service price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                maxLines: 3,
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Service Description",
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelStyle: const TextStyle(color: Color(0xFF4f6d7a)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: Color(0xFF4f6d7a)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF4f6d7a)),
                  ),
                ),
              ),
              const SizedBox(height: 370),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/service-provider');
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.black)),
                  ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF4f6d7a), // Background color
                      padding: const EdgeInsets.symmetric(
                        horizontal: 33,
                        vertical: 14,
                      ), // Increase the size
                    ),
                    child: const Text('Add Service',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }

  void _navigateToCreateLocation(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/create-location');
  }
}
