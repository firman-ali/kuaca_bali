import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/interface/login_page.dart';
import 'package:kuaca_bali/interface/welcome_page.dart';

import 'common/style.dart';

void main() {
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
      },
    );
  }
}
