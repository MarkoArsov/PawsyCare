import 'package:flutter/material.dart';
import 'package:pawsy_care/data-access/firestore.dart';

class PetOwnerProfileScreen extends StatefulWidget {
  const PetOwnerProfileScreen({super.key});

  @override
  State<PetOwnerProfileScreen> createState() => _PetOwnerProfileScreenState();
}

class _PetOwnerProfileScreenState extends State<PetOwnerProfileScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  var isLoading = true;

  String userid = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    String userId = _firestoreService.getCurrentUserID();
    setState(() {
      userid = userId;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Pawsy Care',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.schedule,
                    size: 180,
                    color: Color(0xFF4f6d7a),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Coming soon',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
    );
  }
}
