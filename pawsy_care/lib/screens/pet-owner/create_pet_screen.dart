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
    Navigator.pop(context);
    Navigator.pushNamed(context, '/pet-owner');
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
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Pet Name',
                  labelStyle: const TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.grey[200],
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
                    return 'Please enter pet name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<PetType>(
                value: _selectedPetType,
                items: PetType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(
                      type.toString().split('.').last[0].toUpperCase() +
                          type.toString().split('.').last.substring(1),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPetType = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Type',
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelStyle: const TextStyle(color: Colors.black),
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
              const SizedBox(height: 15),
              TextFormField(
                controller: breedController,
                decoration: InputDecoration(
                  labelText: 'Breed',
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelStyle: const TextStyle(color: Colors.black),
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
                    return 'Please enter pet breed';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelStyle: const TextStyle(color: Colors.black),
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
                    return 'Please enter pet age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: aboutController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'About your pet',
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelStyle: const TextStyle(color: Colors.black),
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
              const SizedBox(height: 40),
              Center(
                child: imageUrl == null
                    ? ElevatedButton(
                        onPressed: takePictureAndUpload,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding:
                              const EdgeInsets.all(20), // increase the size
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Color(0xFF4f6d7a),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        clipBehavior: Clip.hardEdge,
                        width: 140,
                        height: 140,
                        child: Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(height: 152),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/pet-owner');
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addPetFunction();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF4f6d7a), // Background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 33, vertical: 14), // Increase the size
                    ),
                    child: const Text('Add Pet',
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

  void addPetFunction() {
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

      String url = await ref.getDownloadURL();
      setState(() {
        imageUrl = url;
      });
    } on Exception catch (e) {
      imageUrl = "";
      print("Error uploading image: $e");
    }
  }
}
