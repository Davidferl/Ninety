import 'package:bonne_reponse/src/group/domain/post.dart';
import 'package:bonne_reponse/src/group/domain/post_with_user_and_group.dart';
import 'package:bonne_reponse/src/view/addLog/page_select_objective_for_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PostCard extends HookWidget {
  final PostWithUserAndGroup postData;
  final Function(String)? onLike;
  final Function(String)? onComment;

  const PostCard({
    Key? key,
    required this.postData,
    this.onLike,
    this.onComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );
    final scaleAnimation = useAnimation(
      Tween<double>(begin: 1, end: 0.95).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      postData.groupName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Main Post
            Transform.scale(
              scale: scaleAnimation,
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.orange.withOpacity(0.6),
                      Colors.teal.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  image: postData.post.image.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(postData.post.image),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3),
                            BlendMode.darken,
                          ),
                        )
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Info
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(postData.userImageUrl),
                      ),
                      title: Text(
                        postData.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        getLastEntryString(context, postData.post.timestamp),
                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildReactionButton(
                            icon: Icons.favorite,
                            count: postData.post.reactions
                                .where((r) => r.emoji == '❤️')
                                .length,
                            onPressed: () => onLike?.call(postData.post.id),
                            isActive: postData.post.reactions.any(
                              (r) =>
                                  r.userId == 'currentUserId' &&
                                  r.emoji == '❤️',
                            ),
                          ),
                          _buildReactionButton(
                            icon: Icons.chat_bubble,
                            count: postData.post.reactions
                                .where((r) => r.comment != null)
                                .length,
                            onPressed: () => onComment?.call(postData.post.id),
                            isActive: false,
                          ),
                        ],
                      ),
                    ),

                    // Post Content
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            postData.post.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (postData.post.description.isNotEmpty)
                            Text(
                              postData.post.description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          const SizedBox(height: 16),
                          // Quantity indicator
                          _buildQuantityIndicator(postData.post.quantity),
                        ],
                      ),
                    ),

                    // Reactions Preview
                    if (postData.post.reactions.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: _buildReactionsPreview(postData.post.reactions),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionButton({
    required IconData icon,
    required int count,
    required VoidCallback onPressed,
    required bool isActive,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.red : Colors.white,
              size: 20,
            ),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityIndicator(double quantity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.trending_up,
              color: Colors.green[300],
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              quantity.toStringAsFixed(1),
              style: TextStyle(
                color: Colors.green[300],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: quantity / 100,
          backgroundColor: Colors.white.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildReactionsPreview(List<Reaction> reactions) {
    final comments = reactions.where((r) => r.comment != null).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (comments.isNotEmpty) ...[
          const Text(
            'Recent Comments',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...comments.take(2).map((reaction) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  reaction.comment!,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              )),
        ],
      ],
    );
  }
}
