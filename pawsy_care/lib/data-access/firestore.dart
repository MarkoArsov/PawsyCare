import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawsy_care/models/booking.dart';
import 'package:pawsy_care/models/pet.dart';
import 'package:pawsy_care/models/service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');

  final CollectionReference pets =
      FirebaseFirestore.instance.collection('pets');

  final CollectionReference services =
      FirebaseFirestore.instance.collection('services');

  // GET current user ID
  String getCurrentUserID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  // CREATE pet
  Future<void> createPet(Pet pet) {
    return pets.add({
      'userId': pet.userId,
      'name': pet.name,
      'type': pet.type.toString(),
      'breed': pet.breed,
      'age': pet.age,
      'about': pet.about,
    });
  }

  // CREATE service
  Future<void> createService(Service service) {
    return services.add({
      'userId': service.userId,
      'name': service.name,
      'description': service.description,
      'price': service.price,
    });
  }

  // CREATE booking
  Future<void> createBooking(Booking booking) async {
    QuerySnapshot petSnapshot = await pets
        .where('name', isEqualTo: booking.pet.name)
        .where('userId', isEqualTo: booking.pet.userId)
        .get();

    DocumentReference petRef;
    if (petSnapshot.docs.isNotEmpty) {
      petRef = petSnapshot.docs.first.reference;
    } else {
      petRef = await pets.add({
        'userId': booking.pet.userId,
        'name': booking.pet.name,
        'type': booking.pet.type.toString(),
        'breed': booking.pet.breed,
        'age': booking.pet.age,
        'about': booking.pet.about,
      });
    }

    QuerySnapshot serviceSnapshot = await services
        .where('name', isEqualTo: booking.service.name)
        .where('userId', isEqualTo: booking.service.userId)
        .get();

    DocumentReference serviceRef;
    if (serviceSnapshot.docs.isNotEmpty) {
      serviceRef = serviceSnapshot.docs.first.reference;
    } else {
      serviceRef = await services.add({
        'userId': booking.pet.userId,
        'name': booking.service.name,
        'description': booking.service.description,
        'price': booking.service.price,
      });
    }

    await bookings.add({
      'pet': petRef,
      'petUserId': booking.pet.userId,
      'service': serviceRef,
      'serviceUserId': booking.service.userId,
      'date': booking.date,
    });
  }

  // GET pets by user
  Future<List<Pet>> getPetsByUser(String userId) async {
    QuerySnapshot querySnapshot =
        await pets.where('userId', isEqualTo: userId).get();

    return querySnapshot.docs.map((doc) {
      return Pet(
        userId: doc['userId'],
        name: doc['name'],
        type:
            PetType.values.firstWhere((type) => type.toString() == doc['type']),
        breed: doc['breed'],
        age: doc['age'],
        about: doc['about'],
      );
    }).toList();
  }

  // GET all services
  Future<List<Service>> getAllServices() async {
    QuerySnapshot querySnapshot = await services.get();

    return querySnapshot.docs.map((doc) {
      return Service(
        userId: doc['userId'],
        name: doc['name'],
        description: doc['description'],
        price: doc['price'],
      );
    }).toList();
  }

  // GET services by user
  Future<List<Service>> getServicesByUser(String userId) async {
    QuerySnapshot querySnapshot =
        await services.where('userId', isEqualTo: userId).get();

    return querySnapshot.docs.map((doc) {
      return Service(
        userId: doc['userId'],
        name: doc['name'],
        description: doc['description'],
        price: doc['price'],
      );
    }).toList();
  }

  // GET bookings by pet user
  Future<List<Booking>> getBookingsByPetUser(String userId) async {
    QuerySnapshot querySnapshot =
        await bookings.where('petUserId', isEqualTo: userId).get();

    return _getBookingsFromSnapshot(querySnapshot);
  }

  // GET bookings by service user
  Future<List<Booking>> getBookingsByServiceUser(String userId) async {
    QuerySnapshot querySnapshot =
        await bookings.where('serviceUserId', isEqualTo: userId).get();

    return _getBookingsFromSnapshot(querySnapshot);
  }

  // Helper function to convert QuerySnapshot to List of Bookings
  List<Booking> _getBookingsFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Booking(
        pet: doc['pet'],
        service: doc['service'],
        date: doc['date'],
      );
    }).toList();
  }
}
