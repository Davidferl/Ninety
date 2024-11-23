import 'package:bonne_reponse/src/view/addLog/tile.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddLog extends HookWidget {
  const AddLog({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionName(name: 'Log progress'),
                const Text("Pick your objective"),
                const Text("Show the words how it is done!"),
                Expanded(
                    child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
                    child: Tile(
                      imageUri: "assets/images/explore_3.jpg",
                      title: "Sleep at 9pm",
                      description: "Last entry yesterday",
                    ));
                  },
                ))
              ],
            )));
  }
}
