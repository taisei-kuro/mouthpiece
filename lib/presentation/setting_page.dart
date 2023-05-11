import 'package:flutter/material.dart';
import 'package:mouthpiece/common/setting_menu_item.dart';
import 'package:mouthpiece/const/const.dart';
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Const.mainBlueColor,
                ),
                onPressed: () {
                  // widget.controller.nextPage(
                  //   duration: const Duration(milliseconds: 200),
                  //   curve: Curves.linear,
                  // );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SettingMenuItem(
                  label: '背景画像設定',
                  onPressed: () async {
                    // final shouldShow =
                    //     await widget.showSuggestSubscriptionPage();

                    // if (shouldShow || !mounted) {
                    //   return;
                    // }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const SetBackgroundImagePage(),
                    //   ),
                    // );
                  },
                ),
                SettingMenuItem(
                  label: "お問い合せ",
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (builder) =>
                    //         const ContactUsAndResignMenuPage(),
                    //   ),
                    // );
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
