import 'package:bonne_reponse/src/group/domain/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'objective.g.dart';

@JsonSerializable()
class Objective {
  final List<Post> posts = const [];
  final String unit;
  final int quantity;

  Objective({
    required this.unit,
    required this.quantity,
  });

  factory Objective.fromJson(Map<String, dynamic> json) =>
      _$ObjectiveFromJson(json);
  Map<String, dynamic> toJson() => _$ObjectiveToJson(this);
}
