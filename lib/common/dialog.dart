import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({required this.errorMessage, Key? key}) : super(key: key);

  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('エラー'),
      content: Text(errorMessage),
      actions: [
        DialogActionsTextButton(
          buttonText: '閉じる',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

class DialogActionsTextButton extends StatelessWidget {
  const DialogActionsTextButton({
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}

class YesNoDialog extends StatelessWidget {
  const YesNoDialog({
    required this.title,
    this.content,
    required this.onPressedYes,
    this.onPressedNo,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget? content;
  final VoidCallback onPressedYes;
  final VoidCallback? onPressedNo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        DialogActionsTextButton(
          buttonText: 'いいえ',
          onPressed: onPressedNo ??
              () {
                return Navigator.pop(context);
              },
        ),
        DialogActionsTextButton(
          buttonText: 'はい',
          onPressed: onPressedYes,
        ),
      ],
    );
  }
}

class OKDialog extends StatelessWidget {
  const OKDialog({
    required this.title,
    this.content,
    required this.onPressedOK,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget? content;
  final VoidCallback onPressedOK;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        DialogActionsTextButton(
          buttonText: 'OK',
          onPressed: onPressedOK,
        ),
      ],
    );
  }
}
