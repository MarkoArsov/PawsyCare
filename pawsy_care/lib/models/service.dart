import 'package:pawsy_care/models/pawsy_location.dart';

class Service {
  String userId;
  PawsyLocation location;
  String name;
  String description;
  double price;

  Service({
    required this.userId,
    required this.location,
    required this.name,
    required this.description,
    required this.price,
  });
}
