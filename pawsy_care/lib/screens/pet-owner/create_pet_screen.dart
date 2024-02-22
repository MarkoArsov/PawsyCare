import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/pet.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  String? imageUrl;

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
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  takePictureAndUpload();
                },
                child: IconButton(
                    onPressed: () => {takePictureAndUpload()},
                    icon: const Icon(Icons.camera_alt)),
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
                    imageUrl: imageUrl!,
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

  Future<void> takePictureAndUpload() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.camera);
    if (file == null) {
      return;
    }

    Reference refRoot = FirebaseStorage.instance.ref();
    Reference ref = refRoot.child(
        '${_firestoreService.getCurrentUserID()}/pets/${nameController.text}');

    try {
      SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );
      await ref.putFile(File(file.path), metadata);
      imageUrl = await ref.getDownloadURL();
    } on Exception catch (e) {
      imageUrl = "";
      print("Error uploading image: $e");
    }
  }
}
