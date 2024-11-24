import 'package:bonne_reponse/src/group/domain/post.dart';

class PostWithUserAndGroup {
  final String groupName;
  final String userImageUrl;
  final String userName;
  final Post post;

  PostWithUserAndGroup({
    required this.groupName,
    required this.userImageUrl,
    required this.userName,
    required this.post,
  });
}
