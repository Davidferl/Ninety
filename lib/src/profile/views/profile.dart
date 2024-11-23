import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Profile extends HookWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Column(children: [Center(child: Text("Hello from profile page."),)],));
  }

}