import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPress,
  });
  final String text;
  final Widget? icon;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPress,
      icon: icon,
      label: Text(text),
    );
  }
}
