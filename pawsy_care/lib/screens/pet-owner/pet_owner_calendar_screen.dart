import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pawsy_care/controllers/nav_bar_controller.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/booking.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: _getCalendarData(),
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.calendarCell) {
            _handleDateTap(context, details.date!);
          }
        },
      ),

    );
  }

  _DataSource _getCalendarData() {
    List<Appointment> appointments = [];

    for (var booking in bookings) {
      appointments.add(Appointment(
        startTime: booking.date,
        endTime: booking.date.add(const Duration(hours: 2)),
        subject: booking.service.name,
      ));
    }

    return _DataSource(appointments);
  }

  void _handleDateTap(BuildContext context, DateTime selectedDate) {
    List<Booking> selectedBookings = bookings
        .where((booking) =>
            booking.date.year == selectedDate.year &&
            booking.date.month == selectedDate.month &&
            booking.date.day == selectedDate.day)
        .toList();

    if (selectedBookings.isNotEmpty) {
      _showBookingsDialog(context, selectedDate, selectedBookings);
    }
  }

  void _showBookingsDialog(
      BuildContext context, DateTime selectedDate, List<Booking> bookings) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bookings on ${selectedDate.toLocal()}'),
          content: Column(
            children: bookings
                .map((booking) => Text(
                    '${booking.service.name} - ${booking.date.hour}:${booking.date..minute}'))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
