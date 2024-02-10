import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/booking.dart';
import 'package:pawsy_care/widgets/bookings/booking_card_widget.dart';

class ServiceProviderCalendarScreen extends StatefulWidget {
  const ServiceProviderCalendarScreen({super.key});

  @override
  ServiceProviderCalendarScreenState createState() =>
      ServiceProviderCalendarScreenState();
}

class ServiceProviderCalendarScreenState
    extends State<ServiceProviderCalendarScreen> {
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
        await _firestoreService.getBookingsByServiceUser(userId);
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
            Navigator.pushReplacementNamed(context, '/service-list');
          }
        },
      ),
    );
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
