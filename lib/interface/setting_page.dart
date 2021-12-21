import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/interface/register_seller_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/widget/menu_button.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            const PageBar(
              mainPage: true,
              title: 'Settings',
              menuButton: MenuButtonHome(),
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Setings',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Consumer<AuthProvider>(
                  builder: (context, snapshot, child) {
                    return SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: NetworkImage(
                                snapshot.user.imageUrl ??
                                    'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  snapshot.user.name,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.call, color: primary300),
                                    Text(
                                      snapshot.user.phoneNumber,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.home, color: primary300),
                                    Text(snapshot.user.address,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              textDirection: TextDirection.rtl,
                              color: secondary300,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tokoku',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Consumer<AuthProvider>(builder: (context, snapshot, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.store, color: primary300),
                                Text(
                                  snapshot.user.storeName ?? 'Nama Toko',
                                  style: Theme.of(context).textTheme.headline5,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.house, color: primary300),
                                Text(
                                  snapshot.user.storeAddress ?? 'Alamat Toko',
                                  style: Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          pushNewScreen(
                            context,
                            screen: RegisterSellerPage(userData: snapshot.user),
                            withNavBar: false,
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          textDirection: TextDirection.rtl,
                          color: secondary300,
                        ),
                      )
                    ],
                  );
                }),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Buat Dagangan', style: TextStyle(fontSize: 25)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    textDirection: TextDirection.rtl,
                    color: secondary300,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Preferance Settings',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Night Mode',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                CupertinoSwitch(
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
