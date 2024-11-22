import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Startup extends HookWidget {
  const Startup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");

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

    return Scaffold(
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
        color: const Color(0xFFD0F0C0),
        child: const Center(),
      ),
    );
  }
}
