import 'package:flutter/material.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/booking.dart';
import 'package:pawsy_care/models/pet.dart';
import 'package:pawsy_care/models/service.dart';
import 'package:pawsy_care/widgets/services/book_service_widget.dart';
import 'package:pawsy_care/widgets/services/service_card.widget.dart';

class BookServicesScreen extends StatefulWidget {
  const BookServicesScreen({super.key});

  @override
  BookServicesScreenState createState() => BookServicesScreenState();
}

class BookServicesScreenState extends State<BookServicesScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  final List<Service> services = [];

  final List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    _loadServices();
    _loadPets();
  }

  Future<void> _loadServices() async {
    List<Service> userServices = await _firestoreService.getAllServices();
    setState(() {
      services.addAll(userServices);
    });
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
        children: services.map((service) {
          return GestureDetector(
            onTap: () {
              _bookService(context, service);
            },
            child: ServiceCardWidget(service: service),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _bookService(BuildContext context, Service service) async {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: BookServiceWidget(
              service: service,
              pets: pets,
              addBooking: addBooking,
            ),
          );
        });
  }

  void addBooking(Booking booking) {
    _firestoreService.createBooking(booking);
  }
}
