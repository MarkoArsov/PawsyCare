import 'package:flutter/material.dart';
import 'package:pawsy_care/models/pet.dart';
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
      appBar: AppBar(
        title: const Text('Pawsy Care'),
      ),
      body: ListView(
        children: pets.map((pet) => PetCardWidget(pet: pet)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/create-pet'),
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
}
