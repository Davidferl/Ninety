import 'package:bonne_reponse/src/group/domain/post.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'objective.g.dart';

enum QuantityType { discrete, continuous }

@JsonSerializable(explicitToJson: true)
class Objective {
  final String objectiveId;
  final String groupId;
  final String memberId;
  final List<Post> posts;
  final String title;
  final String unit;
  final double quantity;

  @JsonKey(
      unknownEnumValue:
          QuantityType.discrete) // Cast invalid values to QuantityType.discrete
  final QuantityType quantityType;

  Objective({
    String? objectiveId,
    required this.groupId,
    required this.memberId,
    List<Post>? posts,
    required this.title,
    required this.unit,
    required this.quantity,
    required this.quantityType,
  })  : posts = posts ?? const [],
        objectiveId = objectiveId ?? const Uuid().v4();

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

  double getTotalProgress() {
    double total = 0;
    for (var post in posts) {
      total += post.quantity;
    }
    return total;
  }

  DateTime? getLastPostTimestamp() {
    if (posts.isEmpty) {
      return null;
    }
    return posts.last.timestamp;
  }
}
