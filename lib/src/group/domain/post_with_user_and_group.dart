import 'package:bonne_reponse/src/group/domain/post.dart';
import 'package:bonne_reponse/src/user/domain/user.dart';

class PostWithUserAndGroup {
  final String groupName;
  final User user;
  final Post post;

  PostWithUserAndGroup({
    required this.groupName,
    required this.user,
    required this.post,
  });
}
