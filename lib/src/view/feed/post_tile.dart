import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/group/domain/post_with_user_and_group.dart';
import 'package:bonne_reponse/src/view/addLog/page_select_objective_for_log.dart';
import 'package:bonne_reponse/src/view/feed/post_content.dart';
import 'package:bonne_reponse/src/view/feed/post_header.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final PostWithUserAndGroup postWithUserAndGroup;

  const PostTile({super.key, required this.postWithUserAndGroup});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostHeader(
          userImageUrl:
              'https://source.boringavatars.com/beam/120/${postWithUserAndGroup.userName}',
          username: postWithUserAndGroup.userName,
          groupName: postWithUserAndGroup.groupName,
          timeAgo:
              getLastEntryString(context, postWithUserAndGroup.post.timestamp),
        ),
        verticalSpaceSmall,
        PostContent(postWithUserAndGroup: postWithUserAndGroup),
      ],
    );
  }
}
