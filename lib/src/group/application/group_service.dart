import 'dart:io';

import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:bonne_reponse/src/group/domain/member.dart';
import 'package:bonne_reponse/src/group/domain/objective.dart';
import 'package:bonne_reponse/src/group/domain/post.dart';
import 'package:bonne_reponse/src/group/infra/group_repo.dart';
import 'package:bonne_reponse/src/user/domain/user.dart';
import 'package:bonne_reponse/src/user/infra/user_repo.dart';

class GroupService {
  final GroupRepository _groupRepository = locator<GroupRepository>();
  final UserRepository _userRepository = locator<UserRepository>();

  Future<void> addGroup(String title, String description, List<String> tags,
      List<Member> members) async {
    final Group group = Group(
      title: title,
      description: description,
      tags: tags,
      members: members,
    );
    await _groupRepository.save(group);
  }

  Future<Group> getGroup(String groupId) async {
    return await _groupRepository.getById(groupId);
  }

  Future<List<Objective>> getObjectives(String memberId) async {
    List<Group> groups = await _groupRepository.getAll();
    return groups
        .expand((group) => group.members)
        .where((member) => member.userId == memberId)
        .map((member) => member.objective)
        .toList();
  }

  Future<void> addMember(
      String groupId, String memberId, double quantity, String unit) async {
    Group group = await _groupRepository.getById(groupId);

    Objective objective = Objective(unit: unit, quantity: quantity);
    Member member = Member(userId: memberId, objective: objective);
    group.members.add(member);

    await _groupRepository.save(group);

    User user = await _userRepository.getById(memberId);
    user.groupIds.add(groupId);
    await _userRepository.save(user);
  }

  Future<void> logActivity(String groupId, String memberId, String title,
      String description, double quantity, File image) async {
    Group group = await _groupRepository.getById(groupId);

    Member member =
        group.members.firstWhere((member) => member.userId == memberId);

    // TODO : Upload image
    String imageUrl = image.path;

    Post post = Post(
        title: title,
        description: description,
        quantity: quantity,
        image: imageUrl);

    member.objective.posts.add(post);

    await _groupRepository.save(group);
  }

  // Thom en bas moi en haut

  Future<void> reactToPost(String groupId, String userId, String postId) async {
    Group group = await _groupRepository.getById(groupId);

    Member member =
        group.members.firstWhere((member) => member.userId == userId);
    Post post = member.objective.posts.firstWhere((post) => post.id == postId);

    if (post.likes.contains(userId)) {
      post.likes.remove(userId);
    } else {
      post.likes.add(userId);
    }

    await _groupRepository.save(group);
  }

  Future<List<Post>> getGroupsFeed(String userId) async {
    List<Group> groups = await _groupRepository.getAll();
    List<Post> posts = [];

    posts.addAll(
      groups
          .where(
              (group) => group.members.any((member) => member.userId == userId))
          .expand((group) => group.members)
          .expand((member) => member.objective.posts),
    );

    posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return posts;
  }

  Future<List<Post>> getGroupFeed(String userId, String groupId) async {
    Group group = await _groupRepository.getById(groupId);

    List<Post> posts = group.members
        .expand((member) => member.objective.posts)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return posts;
  }

  Future<List<Group>> getGroups({List<String>? tags}) async {
    List<Group> groups = await _groupRepository.getAll();

    if (tags != null) {
      groups.sort((a, b) {
        int aScore = a.tags.fold<int>(
            0, (previousValue, tag) => tags.contains(tag) ? 1 : 0);
        int bScore = b.tags.fold<int>(
            0, (previousValue, tag) => tags.contains(tag) ? 1 : 0);

        return bScore.compareTo(aScore);
      });
    }

    return groups;
  }
}
