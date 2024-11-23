import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../main.dart';
import '../../authentication/hooks/use_authentication.dart';

class Page1 extends HookWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = useAuthentication();

    void onLogout() {
      context.goNamed(Routes.login.name);
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to page 1'),
            ElevatedButton(
              onPressed: () => auth.logout(onLogout),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
