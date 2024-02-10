import 'package:flutter/material.dart';
import 'package:pawsy_care/models/booking.dart';

class BookingCardWidget extends StatelessWidget {
  final Booking booking;

  const BookingCardWidget({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.pet.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(
              booking.service.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(booking.service.description,
                style: const TextStyle(fontSize: 15)),
            Text("Price: \$${booking.service.price.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }
}
