import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawsy_care/models/booking.dart';
import 'package:pawsy_care/models/pawsy_location.dart';
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

  final CollectionReference serviceProviders =
      FirebaseFirestore.instance.collection('serviceProviders');

  final CollectionReference petOwners =
      FirebaseFirestore.instance.collection('petOwners');

  final CollectionReference locations =
      FirebaseFirestore.instance.collection('locations');

  // GET current user ID
  String getCurrentUserID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  Future<bool> petOwnerExists(String userId) async {
    final QuerySnapshot query =
        await petOwners.where('userId', isEqualTo: userId).get();

    return query.docs.isNotEmpty;
  }

  Future<bool> serviceProviderExists(String userId) async {
    final QuerySnapshot query =
        await serviceProviders.where('userId', isEqualTo: userId).get();

    return query.docs.isNotEmpty;
  }

  Future<void> addPetOwner(String userId) {
    return petOwners.add({'userId': userId});
  }

  Future<void> addServiceProvider(String userId) {
    return serviceProviders.add({'userId': userId});
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
      'imageUrl': pet.imageUrl,
    });
  }

  // CREATE service
  Future<void> createService(Service service) async {
    QuerySnapshot locationSnapshot = await locations
        .where('name', isEqualTo: service.location.name)
        .where('userId', isEqualTo: service.location.userId)
        .get();

    DocumentReference locationRef;
    if (locationSnapshot.docs.isNotEmpty) {
      locationRef = locationSnapshot.docs.first.reference;
    } else {
      locationRef = await locations.add({
        'userId': service.location.userId,
        'name': service.location.name,
        'latitude': service.location.latitude,
        'longitude': service.location.longitude
      });
    }

    services.add({
      'userId': service.userId,
      'location': locationRef,
      'name': service.name,
      'description': service.description,
      'price': service.price,
    });
  }

  // CREATE service
  Future<void> createLocation(PawsyLocation location) {
    return locations.add({
      'userId': location.userId,
      'name': location.name,
      'latitude': location.latitude,
      'longitude': location.longitude
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
          type: PetType.values
              .firstWhere((type) => type.toString() == doc['type']),
          breed: doc['breed'],
          age: doc['age'],
          about: doc['about'],
          imageUrl: doc['imageUrl']);
    }).toList();
  }

  // GET all services
  Future<List<Service>> getAllServices() async {
    QuerySnapshot querySnapshot = await services.get();

    List<Service> result = [];

    for (var doc in querySnapshot.docs) {
      DocumentSnapshot locationDoc = await doc['location'].get();
      result.add(Service(
        userId: doc['userId'],
        location: PawsyLocation(
            latitude: locationDoc['latitude'],
            longitude: locationDoc['longitude'],
            name: locationDoc['name'],
            userId: locationDoc['userId']),
        name: doc['name'],
        description: doc['description'],
        price: doc['price'],
      ));
    }

    return result;
  }

  // GET services by user
  Future<List<Service>> getServicesByUser(String userId) async {
    QuerySnapshot querySnapshot =
        await services.where('userId', isEqualTo: userId).get();

    List<Service> result = [];

    for (var doc in querySnapshot.docs) {
      DocumentSnapshot locationDoc = await doc['location'].get();
      result.add(Service(
        userId: doc['userId'],
        location: PawsyLocation(
            latitude: locationDoc['latitude'],
            longitude: locationDoc['longitude'],
            name: locationDoc['name'],
            userId: locationDoc['userId']),
        name: doc['name'],
        description: doc['description'],
        price: doc['price'],
      ));
    }

    return result;
  }

  // GET locations by user
  Future<List<PawsyLocation>> getLocationsByUser(String userId) async {
    QuerySnapshot querySnapshot =
        await locations.where('userId', isEqualTo: userId).get();

    return querySnapshot.docs.map((doc) {
      return PawsyLocation(
        userId: doc['userId'],
        name: doc['name'],
        latitude: doc['latitude'],
        longitude: doc['longitude'],
      );
    }).toList();
  }

  // GET bookings by pet user
  Future<List<Booking>> getBookingsByPetUser(String userId) async {
    QuerySnapshot querySnapshot =
        await bookings.where('petUserId', isEqualTo: userId).get();

    List<Future<Booking>> futureBookings =
        _getBookingsFromSnapshot(querySnapshot);
    return Future.wait(futureBookings);
  }

  // GET bookings by service user
  Future<List<Booking>> getBookingsByServiceUser(String userId) async {
    QuerySnapshot querySnapshot =
        await bookings.where('serviceUserId', isEqualTo: userId).get();

    List<Future<Booking>> futureBookings =
        _getBookingsFromSnapshot(querySnapshot);
    return Future.wait(futureBookings);
  }

  // Helper function to convert QuerySnapshot to List of Bookings
  List<Future<Booking>> _getBookingsFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) async {
      DocumentSnapshot petDoc = await doc['pet'].get();
      DocumentSnapshot serviceDoc = await doc['service'].get();
      DocumentSnapshot locationDoc = await serviceDoc['location'].get();

      return Booking(
        pet: Pet(
            userId: petDoc['userId'],
            name: petDoc['name'],
            type: PetType.values
                .firstWhere((type) => type.toString() == petDoc['type']),
            breed: petDoc['breed'],
            age: petDoc['age'],
            about: petDoc['about'],
            imageUrl: petDoc['imageUrl']),
        service: Service(
          userId: serviceDoc['userId'],
          location: PawsyLocation(
              latitude: locationDoc['latitude'],
              longitude: locationDoc['longitude'],
              name: locationDoc['name'],
              userId: locationDoc['userId']),
          name: serviceDoc['name'],
          description: serviceDoc['description'],
          price: serviceDoc['price'],
        ),
        date: doc['date'].toDate(),
      );
    }).toList();
  }
}
