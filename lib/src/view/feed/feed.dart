import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/authentication/hooks/use_authentication.dart';
import 'package:bonne_reponse/src/authentication/services/auth_service.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:bonne_reponse/src/group/domain/post_with_user_and_group.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/feed/group_pictures.dart';
import 'package:bonne_reponse/src/view/feed/post_tile.dart';
import 'package:bonne_reponse/src/view/widgets/no_internet.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ProfileProp {
  final String imageUrl;
  final bool visited;

  ProfileProp({required this.imageUrl, required this.visited});
}

class Feed extends HookWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    GroupService groupService = locator<GroupService>();
    AuthService authService = locator<AuthService>();

    final auth = useAuthentication();

    final postData = useState<List<PostWithUserAndGroup>>([]);
    final groupData = useState<List<Group>>([]);
    final isPostsLoading = useState<bool>(true); // Track post loading status
    final isGroupsLoading = useState<bool>(true); // Track group loading status
    final isConnectedToInternet = useState<bool>(true);

    useEffect(() {
      final connectivityStream =
          Connectivity().onConnectivityChanged.listen((connectivityResult) {
        isConnectedToInternet.value =
            connectivityResult[0] == ConnectivityResult.mobile ||
                connectivityResult[0] == ConnectivityResult.wifi;
      });

      return () => connectivityStream.cancel();
    }, []);

    useEffect(() {
      Future<void> getPosts() async {
        try {
          isPostsLoading.value = true; // Set loading to true
          postData.value =
              await groupService.getPostFeed(authService.currentUser!.uid);
        } finally {
          isPostsLoading.value = false; // Set loading to false
        }
      }

      if (isConnectedToInternet.value) {
        getPosts();
      }
      return () {};
    }, [isConnectedToInternet]);

    useEffect(() {
      Future<void> getGroups() async {
        try {
          isGroupsLoading.value = true; // Set loading to true
          groupData.value =
              await groupService.getMemberGroups(authService.currentUser!.uid);
        } finally {
          isGroupsLoading.value = false; // Set loading to false
        }
      }

      if (isConnectedToInternet.value) {
        getGroups();
      }
      return () {};
    }, [isConnectedToInternet]);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SectionName(name: "Feed"),
            if (isGroupsLoading.value)
              const Center(child: CircularProgressIndicator())
            else if (groupData.value.isEmpty)
              // Show a friendly message if the user is not in any group
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.group_outlined,
                        size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      "You're not part of any groups yet.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: kcPrimary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Check out the Explore section to find and join groups that interest you.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            else if (isConnectedToInternet.value)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: groupData.value
                          .map(
                            (group) => GestureDetector(
                              onTap: () {
                                // Replace this with your desired action
                                print('Group clicked: ${group.title}');
                                // Example: Navigate to a group detail page
                                context.goNamed('feed',
                                    pathParameters: {'groupId': group.groupId},
                                    extra: group);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: GroupPictures(
                                  imageUrl: group.imageUrl,
                                  groupId: group.groupId,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )),
              ),
            Expanded(
              child: !isConnectedToInternet.value
                  ? const NoInternet()
                  : isPostsLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : postData.value.isEmpty
                          ? Container()
                          : ListView.builder(
                              itemCount:
                                  postData.value.length, // Use actual length
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 36.0),
                                  child: PostTile(
                                    postWithUserAndGroup: postData.value[index],
                                    userId: auth.user!.uid,
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
