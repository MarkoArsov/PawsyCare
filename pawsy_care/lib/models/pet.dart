enum PetType { cat, dog }

class Pet {
  String userId;
  String name;
  PetType type;
  String breed;
  int age;
  String about;

  Pet({
    required this.userId,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.about,
  });
}
