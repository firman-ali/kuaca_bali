import 'package:flutter/material.dart';
import 'package:kuaca_bali/helper/page_navigation_helper.dart';
import 'package:kuaca_bali/interface/register_seller_page.dart';
import 'package:kuaca_bali/interface/login_page.dart';
import 'package:kuaca_bali/interface/welcome_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Setting Page'),
          ListTile(
            title: Row(
              children: [
                Text(
                  'Buat Dagangan',
                  style: Theme.of(context).textTheme.subtitle1,
                )
              ],
            ),
            onTap: () {
              pushNewScreen(
                context,
                screen: RegisterSellerPage(),
                withNavBar: false,
              );
            },
          )
        ],
      ),
    );
  }
}
