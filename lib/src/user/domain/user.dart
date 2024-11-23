import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String surname;
  List<String> groupIds;

  User({
    required this.name,
    required this.surname,
    this.groupIds = const [],
  });
}

