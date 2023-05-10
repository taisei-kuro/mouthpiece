import 'package:flutter/material.dart';
import 'package:mouthpiece/const/const.dart';
import 'package:mouthpiece/domain/project.dart';
import 'package:mouthpiece/presentation/set_reason_page.dart';
import 'package:mouthpiece/repository/auth_repository.dart';
import 'package:mouthpiece/repository/image_repository.dart';
import 'package:mouthpiece/repository/project_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repo = ProjectRepository();
  final authRepo = AuthRepository();
  final imageRepo = ImageRepository();
  Project? project;

  Future<void> init() async {
    try {
      final project = await repo.fetchProject();
      setState(() {
        this.project = project;
      });
    } catch (e) {
      if (e == '目標が取得できません') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (builder) => const SetReasonPage(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    final project = this.project;

    if (project == null) {
      return const Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Const.mainBlueColor,
                ),
                onPressed: () {},
              ),
              actions: [
                TextButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text(
                    '歯の写真',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {},
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                Text(project.reason!),
              ],
            )),
          ),
        )
      ],
    );
  }
}
