class User {
  final String name;
  final String surname;

  User({
    required this.name,
    required this.surname,
  });

  toMap() {
    return {
      'name': name,
      'surname': surname,
    };
  }
}