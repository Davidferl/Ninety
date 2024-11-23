class User {
  final String name;
  final String surname;
  List<String> ids;

  User({
    required this.name,
    required this.surname,
    this.ids = const [],
  });

  toMap() {
    return {
      'name': name,
      'surname': surname,
    };
  }
}

