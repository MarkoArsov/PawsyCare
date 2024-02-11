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
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date: ${date.toLocal().toString().split(' ')[0]}'),
                ElevatedButton(
                  child: const Text('Select Date'),
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
                  onPressed: () => selectTime(context),
                  child: const Text('Select Time'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Booking booking = Booking(
                  pet: _selectedPet!,
                  service: widget.service,
                  date: date,
                );
                widget.addBooking(booking);
                Navigator.pop(context);
              },
              child: const Text('Make Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
