import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/search_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/widget/menu_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<AuthProvider>(
                builder: (context, snapshot, child) {
                  if (snapshot.isSignIn &&
                      snapshot.state == ResultState.finished) {
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: snapshot.user.imageUrl != null
                              ? Image.network(
                                  snapshot.user.imageUrl!,
                                  fit: BoxFit.cover,
                                  width: 50.0,
                                  height: 50.0,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/julian-wan-WNoLnJo7tS8-unsplash.jpg',
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Welcome, ' + snapshot.name!,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: onSurface),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/julian-wan-WNoLnJo7tS8-unsplash.jpg',
                            width: 50.0,
                            height: 50.0,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Welcome, User',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(color: onPrimaryWhite),
                        ),
                      ],
                    );
                  }
                },
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      pushNewScreen(
                        context,
                        screen: SearchPage(),
                        withNavBar: false,
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 35,
                      color: onSurface,
                    ),
                  ),
                  const MenuButton()
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
