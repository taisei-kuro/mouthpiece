import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:mouthpiece/common/dialog.dart';
import 'package:mouthpiece/common/no_icon_button.dart';
import 'package:mouthpiece/const/const.dart';
import 'package:mouthpiece/presentation/home_page.dart';
import 'package:mouthpiece/repository/auth_repository.dart';
import 'package:mouthpiece/repository/project_repository.dart';

class SetQuantityPage extends StatefulWidget {
  final String reason;
  const SetQuantityPage({
    super.key,
    required this.reason,
  });

  @override
  State<SetQuantityPage> createState() => _SetQuantityPageState();
}

class _SetQuantityPageState extends State<SetQuantityPage> {
  final authRepo = AuthRepository();
  final projectRepo = ProjectRepository();

  int? quantity;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Const.mainBlueColor,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Text(
            'マウスピースの枚数は？',
            style: TextStyle(
              fontSize: 30,
              color: Const.mainBlueColor,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: TextFormField(
                  maxLength: 5,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '100',
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
                      quantity = int.tryParse(value);
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          NoIconButton(
            isActive: (quantity != null),
            color: Const.mainBlueColor,
            label: '　　　スタートする　　　',
            onPressed: () async {
              startLoading();
              try {
                await authRepo.signInAnonymously();
                await projectRepo.setProject(
                  quantity!,
                  widget.reason,
                );
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                if (!mounted) return;
                Phoenix.rebirth(context);
              } catch (e) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ErrorDialog(
                        errorMessage: e.toString(),
                      );
                    });
              } finally {
                endLoading();
              }
            },
          ),
        ],
      ),
    );
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void endLoading() {
    setState(() {
      isLoading = false;
    });
  }
}
