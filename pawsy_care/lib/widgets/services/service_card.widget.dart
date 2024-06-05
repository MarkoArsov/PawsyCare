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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.grey[300], // Slightly darker background color
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black87),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text(
                  service.description,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Price",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text(
                  "\$${service.price.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Location",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text(
                  service.location.name,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            const Positioned(
              bottom: 0,
              right: 0,
              child: Icon(
                Icons.arrow_right_sharp,
                size: 46,
                color: Color(0xFF4f6d7a),
              ),
            )
          ],
        ),
      ),
    );
  }
}
