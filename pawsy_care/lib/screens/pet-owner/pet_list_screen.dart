import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawsy_care/models/pet.dart';
import 'package:pawsy_care/widgets/pets/create_pet_widget.dart';
import 'package:pawsy_care/widgets/pets/pet_card_widget.dart';
import 'package:pawsy_care/data-access/firestore.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  PetListScreenState createState() => PetListScreenState();
}

class PetListScreenState extends State<PetListScreen> {
  final List<Pet> pets = [];
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
    String userId = _firestoreService.getCurrentUserID();
    List<Pet> userPets = await _firestoreService.getPetsByUser(userId);
    setState(() {
      pets.addAll(userPets);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: pets.map((pet) => PetCardWidget(pet: pet)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseAuth.instance.currentUser != null
            ? _addPetFunction(context)
            : _navigateToLogIn(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Pets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/book-services');
          }
          if (index == 2) {
            Navigator.pushReplacementNamed(context, '/pet-owner-calendar');
          }
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
    _firestoreService.createPet(pet);
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
