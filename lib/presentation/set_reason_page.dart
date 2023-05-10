import 'package:flutter/material.dart';
import 'package:mouthpiece/common/no_icon_button.dart';
import 'package:mouthpiece/const/const.dart';
import 'package:mouthpiece/presentation/set_%20quantity_page.dart';

class SetReasonPage extends StatefulWidget {
  const SetReasonPage({super.key});
  @override
  State<SetReasonPage> createState() => _SetReasonPageState();
}

class _SetReasonPageState extends State<SetReasonPage> {
  String? reason;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Const.mainBlueColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Text(
              'なぜ矯正するんですか？',
              style: TextStyle(
                fontSize: 30,
                color: Const.mainBlueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              minLines: 3,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                alignLabelWithHint: true,
                hintText: 'ここに理由を書いてください',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Const.mainBlueColor,
                    width: 5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Const.mainBlueColor,
                    width: 5,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  reason = value;
                });
              },
            ),
            const SizedBox(height: 16),
            NoIconButton(
              isActive: (reason != null && reason != ''),
              label: '次へ',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SetQuantityPage(
                      reason: reason!,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
