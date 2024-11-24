import 'dart:async';

import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/authentication/services/auth_service.dart';
import 'package:bonne_reponse/src/user/domain/user.dart';
import 'package:bonne_reponse/src/user/infra/user_repo.dart';

class UserService {
  Future<void> createUser(String name, String surname) async {
    AuthService authService = locator<AuthService>();
    UserRepository userRepository = locator<UserRepository>();

    final userId = authService.currentUser!.uid;
    User user = User(id: userId, name: name, surname: surname);

    await userRepository.save(user);
  }

  Future<User> getCurrentUser() async {
    AuthService authService = locator<AuthService>();
    UserRepository userRepository = locator<UserRepository>();

    final userId = authService.currentUser!.uid;
    return await userRepository.getById(userId);
  }
}
