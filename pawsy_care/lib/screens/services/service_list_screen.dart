import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawsy_care/models/service.dart';
import 'package:pawsy_care/widgets/services/create_service_widget.dart';
import 'package:pawsy_care/widgets/services/service_card.widget.dart';

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  ServiceListScreenState createState() => ServiceListScreenState();
}

class ServiceListScreenState extends State<ServiceListScreen> {
  final List<Service> services = [
    Service(
        name: "Dog Walking", description: "Walking dog for 1 hour", price: 123)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => FirebaseAuth.instance.currentUser != null
                ? _addServiceFunction(context)
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
          crossAxisCount: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return ServiceWidget(service: services[index]);
        },
      ),
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
