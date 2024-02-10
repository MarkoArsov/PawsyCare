import 'package:flutter/material.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/booking.dart';
import 'package:pawsy_care/widgets/bookings/booking_card_widget.dart';

class PetOwnerCalendarScreen extends StatefulWidget {
  const PetOwnerCalendarScreen({super.key});

  @override
  PetOwnerCalendarScreenState createState() => PetOwnerCalendarScreenState();
}

class PetOwnerCalendarScreenState extends State<PetOwnerCalendarScreen> {
  final List<Booking> bookings = [];
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    String userId = _firestoreService.getCurrentUserID();
    List<Booking> userBookings =
        await _firestoreService.getBookingsByPetUser(userId);
    setState(() {
      bookings.addAll(userBookings);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // TODO implement calendar
        children: bookings
            .map((booking) => BookingCardWidget(booking: booking))
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/book-services');
          }
        },
      ),
    );
  }
}
