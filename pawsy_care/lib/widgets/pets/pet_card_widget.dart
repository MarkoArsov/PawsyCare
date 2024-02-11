import 'package:flutter/material.dart';

import 'package:pawsy_care/models/pet.dart';

class PetCardWidget extends StatelessWidget {
  final Pet pet;

  const PetCardWidget({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${pet.name}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text("Type: ${pet.type.toString().split('.').last}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Breed: ${pet.breed}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Age: ${pet.age} years", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("About: ${pet.about}", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
