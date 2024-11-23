import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final String image;
  final String title;
  final String description;
  final List<String> likes = const []; // List of userIds
  final DateTime timestamp = DateTime.now();
  final int quantity;

  Post({
    required this.image,
    required this.title,
    required this.description,
    required this.quantity,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
