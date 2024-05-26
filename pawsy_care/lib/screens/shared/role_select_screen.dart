import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      navigateToPetList();
      return;
    }

    bool serviceProvider = await isServiceProvider();

    if (serviceProvider) {
      navigateToServiceList();
      return;
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToPetList() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/pet-owner');
  }

  void navigateToServiceList() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/service-provider');
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
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 240, 240, 247),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // service provider
                  GestureDetector(
                    onTap: () {
                      _firestoreService.addServiceProvider(
                          _firestoreService.getCurrentUserID());
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/service-provider');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 25.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4f6d7a),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons
                                    .content_cut, // Replace with your desired icon
                                size: 50,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "service provider",
                                style: GoogleFonts.quicksand(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // pet owner
                  GestureDetector(
                    onTap: () {
                      _firestoreService
                          .addPetOwner(_firestoreService.getCurrentUserID());
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/pet-owner');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 25.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4f6d7a),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons
                                    .pets_rounded, // Replace with your desired icon
                                size: 50,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "pet owner",
                                style: GoogleFonts.quicksand(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
