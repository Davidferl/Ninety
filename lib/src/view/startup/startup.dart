import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class Startup extends HookWidget {
  const Startup({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO uncomment this when Firebase auth is setup
    //final AuthService authService = locator<AuthService>();

    //useEffect(() {
    //  Future.delayed(const Duration(seconds: 3), () {
    //    if (authService.isLogged()) {
    //      Navigator.pushReplacementNamed(context, Routes.hub.name);
    //    } else {
    //      Navigator.pushReplacementNamed(context, Routes.login.name);
    //    }
    //  });
    //  return null;
    //}, const []);

    useEffect(() {
      Future.delayed(const Duration(seconds: 3), () {
        context.goNamed(Routes.login.name);
      });
      return null;
    }, []);

    return Scaffold(
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
        color: const Color.fromARGB(255, 51, 114, 15),
        child: const Center(),
      ),
    );
  }
}
