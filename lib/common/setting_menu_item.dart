import 'package:flutter/material.dart';
import 'package:mouthpiece/const/const.dart';

class SettingMenuItem extends StatelessWidget {
  const SettingMenuItem({
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            side: const BorderSide(
              color: Const.mainBlueColor,
              width: 3,
            ),
            backgroundColor: Colors.black,
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Const.mainBlueColor,
            ),
          ),
        ),
      ),
    );
  }
}
