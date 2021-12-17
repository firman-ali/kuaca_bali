import 'package:flutter/material.dart';
import 'package:kuaca_bali/interface/register_seller_page.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(
          children: [
            const PageBar(mainPage: true, title: 'Settings'),
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
      ),
    );
  }
}
