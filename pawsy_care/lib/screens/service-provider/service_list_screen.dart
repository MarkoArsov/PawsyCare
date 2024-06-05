import 'package:flutter/material.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/service.dart';
import 'package:pawsy_care/widgets/services/service_card.widget.dart';

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  ServiceListScreenState createState() => ServiceListScreenState();
}

class ServiceListScreenState extends State<ServiceListScreen> {
  final List<Service> services = [];
  final FirestoreService _firestoreService = FirestoreService();
  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    String userId = _firestoreService.getCurrentUserID();
    List<Service> userServices =
        await _firestoreService.getServicesByUser(userId);
    setState(() {
      services.addAll(userServices);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: services
            .map((service) => ServiceCardWidget(service: service))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushReplacementNamed(context, '/create-service'),
        backgroundColor: const Color(0xFF4f6d7a),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
