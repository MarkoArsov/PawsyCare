import 'package:flutter/material.dart';
import 'package:pawsy_care/models/service.dart';

class CreateServiceWidget extends StatefulWidget {
  final Function(Service) addService;

  const CreateServiceWidget({required this.addService, super.key});

  @override
  CreateServiceWidgetState createState() => CreateServiceWidgetState();
}

class CreateServiceWidgetState extends State<CreateServiceWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  userId: '',
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.parse(priceController.text),
                );
                widget.addService(service);
                Navigator.pop(context);
              },
              child: const Text('Add Exam'),
            ),
          ],
        ),
      ),
    );
  }
}
