import 'package:flutter/material.dart';
import 'package:pawsy_care/models/booking.dart';
import 'package:pawsy_care/models/pet.dart';
import 'package:pawsy_care/models/service.dart';

class BookServiceWidget extends StatefulWidget {
  final List<Pet> pets;
  final Service service;
  final Function(Booking) addBooking;

  const BookServiceWidget(
      {required this.pets,
      required this.service,
      required this.addBooking,
      super.key});

  @override
  BookServiceWidgetState createState() => BookServiceWidgetState();
}

class BookServiceWidgetState extends State<BookServiceWidget> {
  Pet? _selectedPet;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (datePicked != null && datePicked != date) {
      setState(() {
        date = datePicked;
      });
    }
  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(date),
    );

    if (timePicked != null && timePicked != time) {
      setState(() {
        date = DateTime(
          date.year,
          date.month,
          date.day,
          timePicked.hour,
          timePicked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: _selectedPet,
              items: widget.pets.map((pet) {
                return DropdownMenuItem(
                  value: pet,
                  child: Text(pet.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPet = value as Pet;
                });
              },
              decoration: InputDecoration(
                labelText: 'Choose Pet',
                filled: true,
                fillColor: Colors.grey[200],
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: Color(0xFF4f6d7a)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF4f6d7a)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date: ${date.toLocal().toString().split(' ')[0]}'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4f6d7a),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 33, vertical: 14)),
                  child: const Text('Select Date',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () => selectDate(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Time: ${date.toLocal().toString().split(' ')[1].substring(0, 5)}'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4f6d7a),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 33, vertical: 14)),
                  onPressed: () => selectTime(context),
                  child: const Text('Select Time',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 210),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4f6d7a),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 33, vertical: 14)),
              onPressed: () {
                Booking booking = Booking(
                  pet: _selectedPet!,
                  service: widget.service,
                  date: date,
                );
                widget.addBooking(booking);
                Navigator.pop(context);
              },
              child: const Text('Make Booking',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
