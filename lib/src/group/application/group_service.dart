import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:bonne_reponse/src/group/domain/member.dart';
import 'package:bonne_reponse/src/group/domain/objective.dart';
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

  Future<void> addMember(
      String groupId, String memberId, int quantity, String unit) async {
    Group group = await _groupRepository.getById(groupId);

    Objective objective = Objective(unit: unit, quantity: quantity);
    Member member = Member(userId: memberId, objective: objective);
    group.members.add(member);

    await _groupRepository.save(group);

    User user = await _userRepository.getUser(memberId);
    user.groupIds.add(groupId);
  }
}
