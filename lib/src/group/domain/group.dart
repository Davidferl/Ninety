import 'package:bonne_reponse/src/group/domain/member.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String groupId = const Uuid().v4();
  final String title;
  final String description;
  final List<String> tags;
  final List<Member> members;

  Group({
    required this.title,
    required this.description,
    required this.tags,
    required this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
