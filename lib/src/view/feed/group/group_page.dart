import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/main.dart';
import 'package:bonne_reponse/src/authentication/hooks/use_authentication.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:bonne_reponse/src/group/domain/post_with_user_and_group.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/addLog/page_select_objective_for_log.dart';
import 'package:bonne_reponse/src/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class GroupPage extends HookWidget {
  final Group group;
  final String groupId;

  const GroupPage({
    super.key,
    required this.group,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    final groupService = locator<GroupService>();
    final postsWithUserAndGroup = useState<List<PostWithUserAndGroup>>([]);
    final isLoading = useState(true);

    useEffect(() {
      Future<void> fetchGroup() async {
        try {
          final fetchedGroup = await groupService.getGroupFeed(groupId);
          postsWithUserAndGroup.value = fetchedGroup;
        } finally {
          isLoading.value = false;
        }
      }

      fetchGroup();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(color: kcPrimary),
                  )
                : postsWithUserAndGroup.value.isEmpty
                    ? _buildEmptyState(context)
                    : _buildPostsFeed(context, postsWithUserAndGroup.value),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              group.title,
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
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.post_add_rounded,
              size: 64,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'No posts yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Be the first one to share something amazing with the group!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsFeed(
      BuildContext context, List<PostWithUserAndGroup> posts) {
    // First post is featured, remaining go in the masonry grid
    final featuredPost = posts[0];
    final remainingPosts = posts.sublist(1);

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPostCard(context, featuredPost), // Featured Post
          _buildMasonryGrid(context, remainingPosts), // Masonry Grid
        ],
      ),
    );
  }

  Widget _buildMasonryGrid(
      BuildContext context, List<PostWithUserAndGroup> posts) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: MasonryGridView.count(
          padding: const EdgeInsets.only(top: 10),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: posts.length,
          physics:
              const NeverScrollableScrollPhysics(), // Disable nested scrolling
          shrinkWrap: true, // Let it fit the content
          itemBuilder: (BuildContext context, int index) {
            return _buildMasonryPostCard(context, posts[index]);
          },
        ));
  }

  Widget _buildMasonryPostCard(
      BuildContext context, PostWithUserAndGroup post) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 150, // Adjust this value to make the cards taller
      ),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(0),
        image: DecorationImage(
          image: NetworkImage(post.post.image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.post.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              post.userName,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPostCard(BuildContext context, PostWithUserAndGroup post) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.orange.withOpacity(0.6),
          Colors.teal.withOpacity(0.3),
        ],
      ),
      borderRadius: BorderRadius.circular(3),
      image: DecorationImage(
        image: NetworkImage(post.post.image),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.3),
          BlendMode.darken,
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(context, post),
        _buildPostContent(context, post),
      ],
    ),
  );
}

Widget _buildPostHeader(BuildContext context, PostWithUserAndGroup post) {
  final groupService = locator<GroupService>(); // Get the group service
  final auth = useAuthentication(); // Hook for authentication
  final userId = auth.user!.uid; // Get current user's ID

  final isLiked = useState<bool>(
    post.post.reactions.map((e) => e.userId).contains(userId),
  );

  void toggleLike(PostWithUserAndGroup post) {
    if (isLiked.value) {
      // Remove the reaction if already liked
      groupService.removeReaction(post.post.groupId, post.post.id);
      isLiked.value = false; // Update the state
    } else {
      // Add the reaction if not liked
      groupService.reactToPost(post.post.groupId, post.post.id, emoji: "👍");
      isLiked.value = true; // Update the state
    }
  }

  return ListTile(
    leading: CircleAvatar(
        child: BoringAvatar(
            palette: const BoringAvatarPalette(
                [kcPrimary, kcSecondaryVariant, kcLightPrimary]),
            shape: const OvalBorder(),
            name: useAuthentication().user!.uid,
            type: BoringAvatarType.beam)),
    title: Text(
      post.userName,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(
      getLastEntryString(context, post.post.timestamp),
      style: TextStyle(color: Colors.white.withOpacity(0.7)),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: isLiked.value ? Colors.red : Colors.white,
          ),
          onPressed: () => toggleLike(post),
        ),
        IconButton(
          icon: const Icon(Icons.chat_bubble, color: Colors.white),
          onPressed: () => context.goNamed(Routes.comments.name),
        ),
      ],
    ),
  );
}

Widget _buildPostContent(BuildContext context, PostWithUserAndGroup post) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.post.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (post.post.description.isNotEmpty)
          Text(
            post.post.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        const SizedBox(height: 16),
        _buildQuantityIndicator(post.post.quantity),
      ],
    ),
  );
}

Widget _buildQuantityIndicator(double quantity) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.trending_up, color: Colors.green[300], size: 20),
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
      ),
    ],
  );
}
