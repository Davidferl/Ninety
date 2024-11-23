import 'package:bonne_reponse/src/group/domain/objective.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  final String userId; // MemberId is userId
  final Objective objective;

  Member({
    required this.userId,
    required this.objective,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
