import 'package:flutter/material.dart';
import 'package:pawsy_care/models/booking.dart';
import 'package:pawsy_care/models/service.dart';
import 'package:pawsy_care/widgets/services/service_card.widget.dart';

class BookServicesScreen extends StatefulWidget {
  const BookServicesScreen({super.key});

  @override
  BookServicesScreenState createState() => BookServicesScreenState();
}

class BookServicesScreenState extends State<BookServicesScreen> {
  final List<Service> services = [];

  final List<Booking> bookings = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: services.map((service) {
          return GestureDetector(
            onTap: () {
              _bookService(context, service);
            },
            child: ServiceCardWidget(service: service),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/pet-list');
          }
          if (index == 2) {
            Navigator.pushReplacementNamed(context, '/pet-owner-calendar');
          }
        },
      ),
    );
  }

  Future<void> _bookService(BuildContext context, Service service) async {
    // TODO implement booking
  }
}
