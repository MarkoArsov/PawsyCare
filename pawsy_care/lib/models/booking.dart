import 'package:pawsy_care/models/pet.dart';
import 'package:pawsy_care/models/service.dart';

class Booking {
  Pet pet;
  Service service;
  DateTime date;

  Booking({required this.pet, required this.service, required this.date});
}
