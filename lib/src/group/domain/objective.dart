import 'package:bonne_reponse/src/group/domain/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'objective.g.dart';

enum QuantityType { discrete, continuous }

@JsonSerializable()
class Objective {
  final List<Post> posts;
  final String unit;
  final double quantity;
  
  @JsonKey(unknownEnumValue: QuantityType.discrete) // Cast invalid values to QuantityType.discrete
  final QuantityType quantityType;

  Objective({
    List<Post>? posts,
    required this.unit,
    required this.quantity,
    required this.quantityType,
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
