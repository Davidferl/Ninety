import 'package:bonne_reponse/src/group/domain/objective.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable(explicitToJson: true)
class Member {
  final String groupId;
  final String userId; // Member id is userId
  final Objective objective;

  Member({
    required this.groupId,
    required this.userId,
    required this.objective,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
