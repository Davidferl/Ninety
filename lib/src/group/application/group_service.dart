import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/authentication/services/auth_service.dart';
import 'package:bonne_reponse/src/exceptions/exceptions.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:bonne_reponse/src/group/domain/member.dart';
import 'package:bonne_reponse/src/group/domain/objective.dart';
import 'package:bonne_reponse/src/group/domain/post.dart';
import 'package:bonne_reponse/src/group/domain/post_with_user_and_group.dart';
import 'package:bonne_reponse/src/group/infra/group_repo.dart';
import 'package:bonne_reponse/src/user/domain/user.dart';
import 'package:bonne_reponse/src/user/infra/user_repo.dart';
import 'package:image_picker/image_picker.dart';

class GroupService {
  final GroupRepository _groupRepository = locator<GroupRepository>();
  final UserRepository _userRepository = locator<UserRepository>();

  String _getUserId() {
    return locator<AuthService>().currentUser!.uid;
  }

  Future<void> addGroup(
      String title, String description, XFile image, List<String> tags) async {
    String imageUrl = await _groupRepository.uploadImage(image);
    final Group group = Group(
      title: title,
      description: description,
      imageUrl: imageUrl,
      tags: tags,
      members: [],
    );
    await _groupRepository.save(group);
  }

  Future<Group> getGroup(String groupId) async {
    return await _groupRepository.getById(groupId);
  }

  Future<List<Post>> getAllPostsOfConnectedUser() async {
    List<Group> groups = await _groupRepository.getAll();
    List<Post> posts = [];

    for (Group group in groups) {
      posts.addAll(group.members
          .where((member) => member.userId == _getUserId())
          .expand((member) => member.objective.posts));
    }

    return posts;
  }

  /// MapEntry<groupImageUrl, Objective>
  Future<List<MapEntry<String, Objective>>> getObjectives() async {
    List<Group> groups = await _groupRepository.getAll();

    return groups
        .expand((group) => group.members.map(
              (member) => MapEntry(group.imageUrl, member),
            ))
        .where((entry) => entry.value.userId == _getUserId())
        .map((entry) => MapEntry(entry.key, entry.value.objective))
        .toList();
  }

  Future<Objective> getObjectiveById(String objectiveId) async {
    List<Group> groups = await _groupRepository.getAll();

    return groups
        .expand((group) => group.members.map(
              (member) => member.objective,
            ))
        .firstWhere((objective) => objective.objectiveId == objectiveId);
  }

  Future<void> addMember(String groupId, String memberId, String title,
      double quantity, String unit, QuantityType quantityType) async {
    Group group = await _groupRepository.getById(groupId);

    Objective objective = Objective(
        groupId: groupId,
        memberId: memberId,
        title: title,
        unit: unit,
        quantity: quantity,
        quantityType: quantityType);
    Member member =
        Member(groupId: groupId, userId: memberId, objective: objective);

    group.members.add(member);

    await _groupRepository.save(group);

    User user = await _userRepository.getById(memberId);
    user.groupIds.add(groupId);
    await _userRepository.save(user);
  }

  Future<void> logActivity(String groupId, String memberId, String title,
      String description, double quantity, XFile image) async {
    Group group = await _groupRepository.getById(groupId);

    Member member =
        group.members.firstWhere((member) => member.userId == memberId);

    String imageUrl = await _groupRepository.uploadImage(image);

    Post post = Post(
        groupId: groupId,
        memberId: memberId,
        title: title,
        description: description,
        quantity: quantity,
        image: imageUrl);

    member.objective.posts.add(post);

    await _groupRepository.save(group);
  }

  /// Throws InvalidActionException if both emoji and comment are null
  Future<void> reactToPost(
    String groupId,
    String userId,
    String postId, {
    String? emoji,
    String? comment,
  }) async {
    if (emoji == null && comment == null) {
      throw const InvalidActionException(
          message: "Both emoji and comment cannot be null");
    }

    Group group = await _groupRepository.getById(groupId);

    Member member =
        group.members.firstWhere((member) => member.userId == userId);
    Post post = member.objective.posts.firstWhere((post) => post.id == postId);

    post.reactions.add(
      Reaction(
        userId: userId,
        emoji: emoji,
        comment: comment,
      ),
    );

    await _groupRepository.save(group);
  }

  Future<List<PostWithUserAndGroup>> getPostFeed(String userId) async {
    List<Group> groups = await _groupRepository.getAll();
    List<PostWithUserAndGroup> posts = [];

    for (Group group in groups) {
      if (group.members.any((member) => member.userId == userId)) {
        for (Member member in group.members) {
          for (Post post in member.objective.posts) {
            User user = await _userRepository.getById(member.userId);
            posts.add(PostWithUserAndGroup(
              userName: user.name,
              userImageUrl: "",
              groupName: group.title,
              objectiveName: member.objective.title,
              post: post,
            ));
          }
        }
      }
    }

    posts.sort((a, b) => b.post.timestamp.compareTo(a.post.timestamp));

    return posts;
  }

  Future<List<PostWithUserAndGroup>> getGroupFeed(String groupId) async {
    Group group = await _groupRepository.getById(groupId);

    List<PostWithUserAndGroup> posts = [];

    for (Member member in group.members) {
      for (Post post in member.objective.posts) {
        User user = await _userRepository.getById(member.userId);
        posts.add(PostWithUserAndGroup(
          userName: user.name,
          userImageUrl: "",
          groupName: group.title,
          objectiveName: member.objective.title,
          post: post,
        ));
      }
    }

    posts.sort((a, b) => b.post.timestamp.compareTo(a.post.timestamp));

    return posts;
  }

  Future<List<Group>> getMemberGroups(String userId) async {
    List<Group> group = await _groupRepository.getAll();
    List<Group> memberGroups = group
        .where(
            (group) => group.members.any((member) => member.userId == userId))
        .toList();

    return memberGroups;
  }

  Future<List<Group>> getGroups({List<String>? tags}) async {
    List<Group> groups = await _groupRepository.getAll();

    if (tags != null) {
      groups.sort((a, b) {
        int aScore = a.tags
            .fold<int>(0, (previousValue, tag) => tags.contains(tag) ? 1 : 0);
        int bScore = b.tags
            .fold<int>(0, (previousValue, tag) => tags.contains(tag) ? 1 : 0);

        return bScore.compareTo(aScore);
      });
    }

    return groups;
  }
}
