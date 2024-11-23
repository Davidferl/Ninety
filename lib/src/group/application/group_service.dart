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
}
