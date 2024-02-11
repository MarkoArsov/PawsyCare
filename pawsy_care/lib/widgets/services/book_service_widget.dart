// import 'package:flutter/material.dart';
// import 'package:pawsy_care/data-access/firestore.dart';
// import 'package:pawsy_care/models/booking.dart';
// import 'package:pawsy_care/models/pet.dart';
// import 'package:pawsy_care/models/service.dart';

// class BookServiceWidget extends StatefulWidget {
//   final List<Pet> pets;
//   final Service service;
//   final Function(Booking) addBooking;

//   const BookServiceWidget(
//       {required this.pets,
//       required this.service,
//       required this.addBooking,
//       super.key});

//   @override
//   BookServiceWidgetState createState() => BookServiceWidgetState();
// }

// class BookServiceWidgetState extends State<BookServiceWidget> {
//   final TextEditingController nameController = TextEditingController();
//   PetType _selectedPetType = PetType.type;
//   final TextEditingController breedController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   final TextEditingController aboutController = TextEditingController();

//   final FirestoreService _firestoreService = FirestoreService();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: 'Pet Name'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter pet name';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 0),
//             DropdownButtonFormField(
//               value: _selectedPetType,
//               items: PetType.values.map((type) {
//                 return DropdownMenuItem(
//                   value: type,
//                   child: Text(type.toString()[0].toUpperCase() +
//                       type.toString().substring(1)),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedPetType = value as PetType;
//                 });
//               },
//               decoration: const InputDecoration(labelText: 'Type'),
//             ),
//             const SizedBox(height: 0),
//             TextFormField(
//               controller: breedController,
//               decoration: const InputDecoration(labelText: 'Breed'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter pet breed';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 0),
//             TextFormField(
//               controller: ageController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Age'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter pet age';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 0),
//             TextFormField(
//               controller: aboutController,
//               decoration: const InputDecoration(labelText: 'About your pet'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Pet pet = Pet(
//                   userId: _firestoreService.getCurrentUserID(),
//                   name: nameController.text,
//                   type: _selectedPetType,
//                   breed: breedController.text,
//                   age: int.parse(ageController.text),
//                   about: aboutController.text,
//                 );
//                 widget.addPet(pet);
//                 Navigator.pop(context);
//               },
//               child: const Text('Add Pet'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
