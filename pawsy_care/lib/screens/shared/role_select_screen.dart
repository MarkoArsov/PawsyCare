import 'package:flutter/material.dart';
import 'package:pawsy_care/data-access/firestore.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkUserType();
  }

  Future<void> _checkUserType() async {
    bool petOwner = await isPetOwner();

    if (petOwner) {
      Navigator.pushReplacementNamed(context, '/pet-list');
      return;
    }

    bool serviceProvider = await isServiceProvider();

    if (serviceProvider) {
      Navigator.pushReplacementNamed(context, '/service-list');
      return;
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> isPetOwner() async {
    String userId = _firestoreService.getCurrentUserID();
    return await _firestoreService.petOwnerExists(userId);
  }

  Future<bool> isServiceProvider() async {
    String userId = _firestoreService.getCurrentUserID();
    return await _firestoreService.serviceProviderExists(userId);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Choose Role'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _firestoreService.addServiceProvider(
                          _firestoreService.getCurrentUserID());
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/service-list');
                    },
                    child: const Text('Service Provider'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _firestoreService
                          .addPetOwner(_firestoreService.getCurrentUserID());
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/pet-list');
                    },
                    child: const Text('Pet owner'),
                  ),
                ],
              ),
            ),
          );
  }
}
