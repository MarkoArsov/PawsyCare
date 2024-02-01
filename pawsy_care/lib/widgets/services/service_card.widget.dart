import 'package:flutter/material.dart';
import 'package:pawsy_care/models/service.dart';

class ServiceWidget extends StatelessWidget {
  final Service service;

  const ServiceWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Service Name: ${service.name}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Description: ${service.description}"),
            Text("Price: \$${service.price.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }
}
