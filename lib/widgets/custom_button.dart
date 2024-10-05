import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  CustomButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
      ),
    );
  }
}
