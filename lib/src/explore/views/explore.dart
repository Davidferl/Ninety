import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Explore extends HookWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Column(children: [Center(child: Text("Hello from profile log."),)],));
  }

}