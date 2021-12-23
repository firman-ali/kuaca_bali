import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/interface/add_item_seller.dart';
import 'package:kuaca_bali/interface/register_seller_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/provider/preference_provider.dart';
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
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
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
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10.0),
                userInformationCard(context),
              ],
            ),
            const SizedBox(height: 30.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tokoku',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10.0),
                storeInformationCard(context),
              ],
            ),
            const SizedBox(height: 20.0),
            createItemCard(context),
            const SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preferance Settings',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10.0),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Night Mode',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Consumer<PreferenceProvider>(
                          builder: (context, snapshot, child) {
                            return CupertinoSwitch(
                              value: snapshot.isDarkTheme,
                              onChanged: (value) {
                                snapshot.enableDarkTheme = value;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget createItemCard(BuildContext context) {
    return InkWell(
      onTap: () {
        final user = Provider.of<AuthProvider>(context, listen: false).user;
        if (user.storeName == null) {
          pushNewScreen(
            context,
            screen: RegisterSellerPage(userData: user),
          );
        } else {
          pushNewScreen(
            context,
            screen: const AdddItemSeller(),
          );
        }
      },
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Buat Dagangan', style: TextStyle(fontSize: 25)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  textDirection: TextDirection.rtl,
                  color: secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget storeInformationCard(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10.0),
      child: Consumer<AuthProvider>(
        builder: (context, snapshot, child) {
          return InkWell(
            onTap: () => pushNewScreen(
              context,
              screen: RegisterSellerPage(userData: snapshot.user),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.store),
                            const SizedBox(width: 5.0),
                            Text(
                              snapshot.user.storeName ?? 'Nama Toko',
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          children: [
                            const Icon(Icons.house),
                            const SizedBox(width: 5.0),
                            Text(
                              snapshot.user.storeAddress ?? 'Alamat Toko',
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      textDirection: TextDirection.rtl,
                      color: secondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget userInformationCard(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10.0),
      child: Consumer<AuthProvider>(
        builder: (context, snapshot, child) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: CircleAvatar(
                    radius: 50,
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
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.call),
                          const SizedBox(width: 5.0),
                          Text(
                            snapshot.user.phoneNumber,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.home),
                          const SizedBox(width: 5.0),
                          Text(
                            snapshot.user.address,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    textDirection: TextDirection.rtl,
                    color: secondary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
