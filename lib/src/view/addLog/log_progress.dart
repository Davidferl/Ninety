import 'package:flutter/material.dart';

class LogProgress extends StatelessWidget {
  final String title;

  const LogProgress({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text("hello")),
    );
  }
}
