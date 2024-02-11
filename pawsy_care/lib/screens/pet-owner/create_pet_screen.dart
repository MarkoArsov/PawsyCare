import 'package:flutter/material.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/pet.dart';

class CreatePetScreen extends StatefulWidget {
  const CreatePetScreen({super.key});

  @override
  CreatePetScreenState createState() => CreatePetScreenState();
}

class CreatePetScreenState extends State<CreatePetScreen> {
  final TextEditingController nameController = TextEditingController();
  PetType _selectedPetType = PetType.dog;
  final TextEditingController breedController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();

  void addPet(Pet pet) {
    _firestoreService.createPet(pet);
    Navigator.pushReplacementNamed(context, '/pet-list');
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
              const SizedBox(height: 50),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Pet Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pet name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                value: _selectedPetType,
                items: PetType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(
                        type.toString().split('.').last[0].toUpperCase() +
                            type.toString().split('.').last.substring(1)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPetType = value as PetType;
                  });
                },
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: breedController,
                decoration: const InputDecoration(labelText: 'Breed'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pet breed';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pet age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: aboutController,
                decoration: const InputDecoration(labelText: 'About your pet'),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Pet pet = Pet(
                    userId: _firestoreService.getCurrentUserID(),
                    name: nameController.text,
                    type: _selectedPetType,
                    breed: breedController.text,
                    age: int.parse(ageController.text),
                    about: aboutController.text,
                  );
                  addPet(pet);
                },
                child: const Text('Add Pet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
