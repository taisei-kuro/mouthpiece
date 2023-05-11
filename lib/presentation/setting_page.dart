import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:mouthpiece/common/dialog.dart';
import 'package:mouthpiece/common/setting_menu_item.dart';
import 'package:mouthpiece/const/const.dart';
import 'package:mouthpiece/repository/auth_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({
    super.key,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

// https://stackoverflow.com/questions/67662298/flutter-how-to-keep-the-page-alive-when-changing-it-with-pageview-or-bottomnav
class _SettingPageState extends State<SettingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String versionString = '';

  @override
  void initState() {
    super.initState();
    fetchVersion();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SettingMenuItem(
                  label: '退会',
                  onPressed: () async {
                    await _showConfirmResignDialog(context);
                  },
                ),
                Text(
                  versionString,
                  style: const TextStyle(color: Const.mainBlueColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future fetchVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    setState(() {
      versionString = '$version+$buildNumber';
    });
  }
}

Future _showConfirmResignDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) {
      return YesNoDialog(
        title: '退会確認',
        content: const Text(
          'これまでの記録が全て削除されます。\n本当に退会しますか？',
        ),
        onPressedYes: () async {
          await AuthRepository().deleteUser();

          if (context.mounted) {
            Navigator.of(context).pop();
            await showDialog(
              context: context,
              builder: (_) {
                return OKDialog(
                  title: '退会が完了しました。',
                  onPressedOK: () async {
                    Navigator.of(context).pop();
                    Phoenix.rebirth(context);
                  },
                );
              },
            );
          }
        },
      );
    },
  );
}
