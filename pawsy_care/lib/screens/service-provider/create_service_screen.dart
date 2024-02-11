import 'package:flutter/material.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/service.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});

  @override
  CreateServiceScreenState createState() => CreateServiceScreenState();
}

class CreateServiceScreenState extends State<CreateServiceScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();

  void addService(Service service) {
    _firestoreService.createService(service);
    Navigator.pushReplacementNamed(context, '/service-list');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pawsy Care'),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Service service = Service(
                    userId: _firestoreService.getCurrentUserID(),
                    name: nameController.text,
                    description: descriptionController.text,
                    price: double.parse(priceController.text),
                  );
                  addService(service);
                },
                child: const Text('Add Exam'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
