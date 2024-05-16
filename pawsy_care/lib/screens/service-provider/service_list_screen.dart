import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/service.dart';
import 'package:pawsy_care/widgets/services/create_service_widget.dart';
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
        onPressed: () => FirebaseAuth.instance.currentUser != null
            ? _addServiceFunction(context)
            : _navigateToLogIn(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Future<void> _addServiceFunction(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: CreateServiceWidget(
              addService: addService,
            ),
          );
        });
  }

  void addService(Service service) {
    setState(() {
      services.add(service);
    });
    _firestoreService.createService(service);
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
