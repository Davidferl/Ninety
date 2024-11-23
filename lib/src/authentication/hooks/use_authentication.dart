import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../injection_container.dart';
import '../services/auth_service.dart';

class AuthenticationState {
  final User? user;
  final Future<void> Function(
      String email, String password, void Function() onSuccess) login;
  final Future<void> Function(void Function() onSuccess) logout;
  final Future<void> Function(String email, String password) register;

  AuthenticationState({
    required this.user,
    required this.login,
    required this.logout,
    required this.register,
  });
}

AuthenticationState useAuthentication() {
  final AuthService authenticationService =
      useMemoized(() => locator<AuthService>(), []);
  final user = useState<User?>(authenticationService.currentUser);

  useEffect(() {
    final listener = authenticationService.userStream.listen((userValue) {
      user.value = userValue;
    });

    return () => listener.cancel();
  }, []);

  Future<void> login(
      String email, String password, void Function() onSuccess) async {
    await authenticationService.login(email, password);

    onSuccess();
  }

  Future<void> register(String email, String password) async {
    await authenticationService.register(email, password);
  }

  Future<void> logout(void Function() onSuccess) async {
    authenticationService.logout();

    onSuccess();
  }

  return AuthenticationState(
      user: user.value, login: login, logout: logout, register: register);
}
