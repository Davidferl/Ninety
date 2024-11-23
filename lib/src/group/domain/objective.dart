import 'package:bonne_reponse/src/group/domain/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'objective.g.dart';

@JsonSerializable()
class Objective {
  final List<Post> posts;
  final String unit;
  final double quantity;

  Objective({
    List<Post>? posts,
    required this.unit,
    required this.quantity,
  }) : posts = posts ?? const [];

  factory Objective.fromJson(Map<String, dynamic> json) =>
      _$ObjectiveFromJson(json);
  Map<String, dynamic> toJson() => _$ObjectiveToJson(this);

  double getProgress() {
    double total = 0;
    for (var post in posts) {
      total += post.quantity;
    }
    return total / quantity;
  }
}
