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
      body: ListView(
        children: pets.map((pet) => PetCardWidget(pet: pet)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/create-pet'),
        backgroundColor: const Color(0xFF4f6d7a),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
