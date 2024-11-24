import 'package:flutter/material.dart';

class SubsectionName extends StatelessWidget {
  final String name;

  const SubsectionName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 12.0),
        child: Text(
          name,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
