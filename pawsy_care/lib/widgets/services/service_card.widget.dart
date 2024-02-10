import 'package:flutter/material.dart';
import 'package:pawsy_care/models/service.dart';

class ServiceCardWidget extends StatelessWidget {
  final Service service;

  const ServiceCardWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(service.description, style: const TextStyle(fontSize: 15)),
            Text("Price: \$${service.price.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }
}
