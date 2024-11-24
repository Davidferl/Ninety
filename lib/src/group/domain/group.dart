import 'package:bonne_reponse/src/group/domain/member.dart';
import 'package:bonne_reponse/src/group/domain/post.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'group.g.dart';

@JsonSerializable(explicitToJson: true)
class Group {
  final String groupId;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> tags;
  final List<Member> members;

  Group({
    String? groupId,
    required this.title,
    required this.description,
    required this.tags,
    required this.members,
    required this.imageUrl,
  }) : groupId = groupId ?? const Uuid().v4();

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);

  List<Post> getPostOrderedByDate() {
    List<Post> posts = [];

    for (Member member in members) {
      posts.addAll(member.objective.posts);
    }

    posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return posts;
  }

  String getPostMemberId(Post post) {
    for (Member member in members) {
      if (member.objective.posts.contains(post)) {
        return member.userId;
      }
    }
    return '';
  }
}
