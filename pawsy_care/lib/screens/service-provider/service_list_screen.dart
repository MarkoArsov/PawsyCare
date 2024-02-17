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
      appBar: AppBar(
        title: const Text('Pawsy Care'),
      ),
      body: ListView(
        children: services
            .map((service) => ServiceCardWidget(service: service))
            .toList(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/create-service'),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          IconButton(
            onPressed: () => {
              Navigator.pushReplacementNamed(context, '/service-provider-map'),
            },
            icon: const Icon(Icons.map),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacementNamed(
                context, '/service-provider-calendar');
          }
        },
      ),
    );
  }
}
