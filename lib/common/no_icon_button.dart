import 'package:flutter/material.dart';
import 'package:mouthpiece/const/const.dart';

class NoIconButton extends StatelessWidget {
  const NoIconButton({
    required this.label,
    this.color,
    this.backgroundColor,
    required this.isActive,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String label;
  final Color? color;
  final Color? backgroundColor;
  final bool isActive;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: isActive
              ? (color ?? Const.mainBlueColor)
              : (color ?? Const.mainBlueColor).withOpacity(0.3),
          width: 3,
        ),
        backgroundColor: isActive
            ? (backgroundColor ?? Colors.white)
            : (backgroundColor ?? Colors.white).withOpacity(0.3),
        padding: const EdgeInsets.all(16.0),
      ),
      onPressed: isActive ? onPressed : null,
      child: Text(
        label,
        style: TextStyle(
          color: isActive
              ? (color ?? Const.mainBlueColor)
              : (color ?? Const.mainBlueColor).withOpacity(0.3),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
