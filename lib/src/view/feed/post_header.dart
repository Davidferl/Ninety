import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/authentication/hooks/use_authentication.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:bonne_reponse/src/group/domain/post.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PostHeader extends HookWidget {
  final Post post;
  final String userImageUrl;
  final String username;
  final String groupName;
  final String timeAgo;

  const PostHeader({
    super.key,
    required this.post,
    required this.userImageUrl,
    required this.username,
    required this.groupName,
    required this.timeAgo,
  });

  void _toggleReaction(
      GroupService groupService, Post post, ValueNotifier<bool> isLiked) {
    if (isLiked.value) {
      // Remove the reaction if already liked
      groupService.removeReaction(post.groupId, post.id);
      isLiked.value = false; // Update the state
    } else {
      // Add the reaction if not liked
      groupService.reactToPost(post.groupId, post.id, emoji: "👍");
      isLiked.value = true; // Update the state
    }
  }

  @override
  Widget build(BuildContext context) {
    const colorPalette =
        BoringAvatarPalette([kcPrimary, kcSecondaryVariant, kcLightPrimary]);

    GroupService groupService = locator<GroupService>();
    final auth = useAuthentication();
    final userId = auth.user!.uid;

    // Use a state hook to track the like status
    final isLiked = useState<bool>(
      post.reactions.map((e) => e.userId).contains(userId),
    );

    return Row(
      children: [
        CircleAvatar(
          child: BoringAvatar(
            palette: colorPalette,
            shape: const OvalBorder(),
            name: userImageUrl,
            type: BoringAvatarType.beam,
          ),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const TextSpan(
                    text: " in ",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: groupName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kcPrimary,
                    ),
                  ),
                ],
              ),
              style: const TextStyle(fontSize: 15), // Global style for the text
            ),
            Text(
              timeAgo,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            LikeButton(
              isLiked: isLiked.value,
              onToggle: () => _toggleReaction(groupService, post, isLiked),
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
