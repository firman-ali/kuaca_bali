import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/interface/home_page.dart';
import 'package:kuaca_bali/interface/login_page.dart';
import 'package:kuaca_bali/interface/register_page.dart';
import 'package:kuaca_bali/interface/welcome_page.dart';

import 'common/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: textTheme,
        elevatedButtonTheme: elevatedButtonTheme,
        textButtonTheme: textButtonTheme,
        inputDecorationTheme: inputTheme,
        backgroundColor: background,
      ),
      home: const WelcomePage(),
      initialRoute: WelcomePage.routeName,
      routes: {
        WelcomePage.routeName: (_) => const WelcomePage(),
        LoginPage.routeName: (_) => const LoginPage(),
        RegisterPage.routeName: (_) => const RegisterPage(),
        HomePage.routeName: (_) => HomePage(),
      },
    );
  }
}
