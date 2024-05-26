import 'package:flutter/material.dart';
import 'package:pawsy_care/data-access/firestore.dart';
import 'package:pawsy_care/models/booking.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

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
  final DateFormat dateFormat = DateFormat('MMMM dd, yyyy');
  final DateFormat timeFormat = DateFormat('HH:mm');

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
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Pawsy Care',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
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
          title: Text(dateFormat.format(selectedDate)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: bookings.map((booking) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  booking.service.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(timeFormat.format(booking.date)),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
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
