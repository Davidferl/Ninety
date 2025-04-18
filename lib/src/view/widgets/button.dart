import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const RoundedButton(
      {super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Set your desired button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Set the border radius
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}

