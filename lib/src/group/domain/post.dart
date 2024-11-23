import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final String id;
  final String image;
  final String title;
  final String description;
  final List<Reaction> reactions;
  final DateTime timestamp;
  final double quantity;

  Post({
    String? id,
    required this.image,
    required this.title,
    required this.description,
    List<Reaction>? reactions,
    DateTime? timestamp,
    required this.quantity,
  })  : id = id ?? const Uuid().v4(),
        reactions = reactions ?? const [],
        timestamp = timestamp ?? DateTime.now();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class Reaction {
  final String userId;
  final String? emoji;
  final String? comment;

  Reaction({
    required this.userId,
    this.emoji,
    this.comment,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) =>
      _$ReactionFromJson(json);
  Map<String, dynamic> toJson() => _$ReactionToJson(this);
}
