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
import 'package:kuaca_bali/provider/bookmark_provider.dart';
import 'package:kuaca_bali/provider/cart_provider.dart.dart';
import 'package:kuaca_bali/provider/home_provider.dart';
import 'package:kuaca_bali/provider/order_history_provider.dart';
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
        ChangeNotifierProvider<OrderHistoryProvider>(
          create: (context) => OrderHistoryProvider(
              dbService: DatabaseService(), authService: AuthService()),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: textTheme,
          elevatedButtonTheme: elevatedButtonTheme,
          textButtonTheme: textButtonTheme,
          inputDecorationTheme: inputTheme,
          backgroundColor: background,
        ),
        home: Consumer<AuthProvider>(builder: (context, snapshot, _) {
          if (snapshot.state == ResultState.isLoading) {
            return const LoadingWidget();
          } else {
            if (snapshot.isSignIn) {
              return PageRouter();
            } else {
              return const WelcomePage();
            }
          }
        }),
        routes: {
          WelcomePage.routeName: (_) => const WelcomePage(),
          LoginPage.routeName: (_) => const LoginPage(),
          RegisterPage.routeName: (_) => const RegisterPage(),
        },
      ),
    );
  }
}
