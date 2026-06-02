import 'package:flutter/material.dart';

/// A simple, reusable button for the Lab.
/// It pops a SnackBar so students see something happened even if the app doesn't crash.
class LabButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const LabButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Action: $label'), duration: const Duration(seconds: 1)),
          );
          onPressed();
        },
        child: Text(label),
      ),
    );
  }
}
