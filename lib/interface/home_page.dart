import 'package:flutter/material.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/interface/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Home Page'),
            ElevatedButton(
                onPressed: () async {
                  final result = await AuthService().userSignOut();
                  if (result == 'User Log Out') {
                    Navigator.pushReplacementNamed(
                        context, LoginPage.routeName);
                  }
                },
                child: const Text('Log Out'))
          ],
        ),
      ),
    );
  }
}
