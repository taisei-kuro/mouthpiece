import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mouthpiece/const/const.dart';
import 'package:mouthpiece/firebase_options_dev.dart' as dev;
import 'package:mouthpiece/firebase_options_prod.dart' as prod;
import 'package:mouthpiece/presentation/home_page.dart';
import 'package:mouthpiece/repository/auth_repository.dart';

const flavor = String.fromEnvironment('FLAVOR');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('ja');

  final firebaseOptions = flavor == 'prod'
      ? prod.DefaultFirebaseOptions.currentPlatform
      : dev.DefaultFirebaseOptions.currentPlatform;
  await Firebase.initializeApp(
    options: firebaseOptions,
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.black,
        title: '矯正記録',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Const.mainBlueColorSwatch,
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
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Const.mainBlueColor,
              fontSize: 20,
            ),
            contentTextStyle: TextStyle(
              color: Const.mainBlueColor,
            ),
          ),
        ),
        home: const HomePage());
  }
}
