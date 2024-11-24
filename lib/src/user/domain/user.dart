import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String id;
  final String name;
  final String surname;
  List<String> groupIds  = const [];

  User({
    required this.id,
    required this.name,
    required this.surname,
  });

  void addGroup(String groupId) {
    groupIds.add(groupId);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
