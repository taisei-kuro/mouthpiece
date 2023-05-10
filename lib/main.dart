import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mouthpiece/const/const.dart';
import 'package:mouthpiece/firebase_options.dart';
import 'package:mouthpiece/presentation/home_page.dart';
import 'package:mouthpiece/repository/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('ja');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AuthRepository().signInAnonymously();

  runApp(
    Phoenix(
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isLogin = AuthRepository().isLogin;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.black,
        title: '矯正記録',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Const.mainBlueColorSwatch,
          fontFamily: Const.fontFamily,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: Colors.transparent,
            ),
          ),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Const.mainBlueColor,
            elevation: 0,
          ),
          dialogTheme: const DialogTheme(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Const.mainBlueColor,
                width: 3,
              ),
            ),
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(
              fontFamily: Const.fontFamily,
              color: Const.mainBlueColor,
              fontSize: 20,
            ),
            contentTextStyle: TextStyle(
              fontFamily: Const.fontFamily,
              color: Const.mainBlueColor,
            ),
          ),
        ),
        home: isLogin ? const HomePage() : const HomePage());
  }
}
