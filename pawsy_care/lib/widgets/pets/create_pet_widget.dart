import 'package:flutter/material.dart';
import 'package:pawsy_care/models/pet.dart';

class CreatePetWidget extends StatefulWidget {
  final Function(Pet) addPet;

  const CreatePetWidget({required this.addPet, super.key});

  @override
  CreatePetWidgetState createState() => CreatePetWidgetState();
}

class CreatePetWidgetState extends State<CreatePetWidget> {
  final TextEditingController nameController = TextEditingController();
  PetType _selectedPetType = PetType.type;
  final TextEditingController breedController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

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
              decoration: const InputDecoration(labelText: 'Pet Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter pet name';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField(
              value: _selectedPetType,
              items: PetType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.toString()[0].toUpperCase() +
                      type.toString().substring(1)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPetType = value as PetType;
                });
              },
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            const SizedBox(height: 50),
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
            const SizedBox(height: 50),
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
            const SizedBox(height: 50),
            TextFormField(
              controller: aboutController,
              decoration: const InputDecoration(labelText: 'About your pet'),
            ),
            ElevatedButton(
              onPressed: () {
                Pet pet = Pet(
                  name: nameController.text,
                  type: _selectedPetType,
                  breed: breedController.text,
                  age: int.parse(ageController.text),
                  about: aboutController.text,
                );
                widget.addPet(pet);
                Navigator.pop(context);
              },
              child: const Text('Add Pet'),
            ),
          ],
        ),
      ),
    );
  }
}
