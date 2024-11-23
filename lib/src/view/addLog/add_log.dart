import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddLog extends HookWidget {
  const AddLog({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Column(children: [Center(child: Text("Hello from Add log."),)],));
  }

}