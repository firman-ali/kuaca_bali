import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/page_navigation_helper.dart';
import 'package:kuaca_bali/helper/preference_helper.dart';
import 'package:kuaca_bali/interface/login_page.dart';
import 'package:kuaca_bali/interface/register_page.dart';
import 'package:kuaca_bali/interface/welcome_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/provider/bookmark_provider.dart';
import 'package:kuaca_bali/provider/cart_provider.dart.dart';
import 'package:kuaca_bali/provider/home_provider.dart';
import 'package:kuaca_bali/provider/preference_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        ChangeNotifierProvider<HomeProvider>(
          create: (BuildContext context) =>
              HomeProvider(dbService: DatabaseService()),
        ),
        ChangeNotifierProvider<BookmarkProvider>(
          create: (_) => BookmarkProvider(
              dbService: DatabaseService(), authService: AuthService()),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(
              dbService: DatabaseService(), authService: AuthService()),
        ),
        ChangeNotifierProvider<PreferenceProvider>(
          create: (_) => PreferenceProvider(
              preferencesHelper: PreferencesHelper(
            sharedPreferences: SharedPreferences.getInstance(),
          )),
        ),
      ],
      child: Phoenix(
        child: Consumer<PreferenceProvider>(
          builder: (context, snapshot, child) {
            return MaterialApp(
              theme: snapshot.themeData,
              home: const PageNavigation(),
              routes: {
                WelcomePage.routeName: (_) => const WelcomePage(),
                LoginPage.routeName: (_) => const LoginPage(),
                RegisterPage.routeName: (_) => const RegisterPage(),
              },
            );
          },
        ),
      ),
    );
  }
}
