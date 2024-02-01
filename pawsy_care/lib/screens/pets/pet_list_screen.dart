import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawsy_care/models/pet.dart';
import 'package:pawsy_care/widgets/pets/create_pet_widget.dart';
import 'package:pawsy_care/widgets/pets/pet_card_widget.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  PetListScreenState createState() => PetListScreenState();
}

class PetListScreenState extends State<PetListScreen> {
  final List<Pet> pets = [
    Pet(
        name: "Riki",
        type: PetType.dog,
        breed: "Dzukac",
        age: 6,
        about: "Scary Dzukela")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => FirebaseAuth.instance.currentUser != null
                ? _addPetFunction(context)
                : _navigateToLogIn(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logOut,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return PetWidget(pet: pets[index]);
        },
      ),
    );
  }

  Future<void> _addPetFunction(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: CreatePetWidget(
              addPet: addPet,
            ),
          );
        });
  }

  void addPet(Pet pet) {
    setState(() {
      pets.add(pet);
    });
  }

  void _navigateToLogIn(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
