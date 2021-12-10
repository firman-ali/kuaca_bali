import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/page_navigation_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/login_page.dart';
import 'package:kuaca_bali/interface/register_page.dart';
import 'package:kuaca_bali/interface/welcome_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/provider/list_data_provider.dart';
import 'package:kuaca_bali/widget/loading.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (BuildContext context) =>
              AuthProvider(service: AuthService()),
        ),
        ChangeNotifierProvider<ListDataProvider>(
          create: (BuildContext context) =>
              ListDataProvider(dbService: DatabaseService()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: textTheme,
          elevatedButtonTheme: elevatedButtonTheme,
          textButtonTheme: textButtonTheme,
          inputDecorationTheme: inputTheme,
          backgroundColor: background,
        ),
        home: PageNavigation(),
        routes: {
          WelcomePage.routeName: (_) => const WelcomePage(),
          LoginPage.routeName: (_) => const LoginPage(),
          RegisterPage.routeName: (_) => const RegisterPage(),
        },
      ),
    );
  }
}
