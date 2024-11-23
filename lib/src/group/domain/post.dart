import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final String id;
  final String image;
  final String title;
  final String description;
  final List<String> likes;
  final DateTime timestamp;
  final int quantity;

  Post({
    String? id,
    required this.image,
    required this.title,
    required this.description,
    List<String>? likes,
    DateTime? timestamp,
    required this.quantity,
  })  : id = id ?? const Uuid().v4(),
        likes = likes ?? const [], // List of userIds
        timestamp = timestamp ?? DateTime.now();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
