enum PetType { type, cat, dog }

class Pet {
  String name;
  PetType type;
  String breed;
  int age;
  String about;

  Pet({
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.about,
  });
}
