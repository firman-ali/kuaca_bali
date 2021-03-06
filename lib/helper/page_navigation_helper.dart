import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/bookmarks_page.dart';
import 'package:kuaca_bali/interface/cart_page.dart';
import 'package:kuaca_bali/interface/list_chats_page.dart';
import 'package:kuaca_bali/interface/home_page.dart';
import 'package:kuaca_bali/interface/setting_page.dart';
import 'package:kuaca_bali/interface/welcome_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/widget/loading.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class PageNavigation extends StatelessWidget {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, snapshot, _) {
        if (snapshot.state == ResultState.isLoading) {
          return const LoadingWidget();
        } else {
          if (snapshot.isSignIn) {
            return const PageRouter();
          } else {
            return const WelcomePage();
          }
        }
      },
    );
  }
}

class PageRouter extends StatefulWidget {
  const PageRouter({Key? key}) : super(key: key);

  @override
  State<PageRouter> createState() => _PageRouterState();
}

class _PageRouterState extends State<PageRouter> {
  PersistentTabController _controller = PersistentTabController();
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: primary600,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      navBarHeight: 60.0,
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style4,
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const BookmarksPage(),
      const ChatPage(),
      const CartPage(),
      const SettingPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Beranda"),
        activeColorPrimary: onPrimaryWhite,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.bookmark),
        title: ("Bookmark"),
        activeColorPrimary: onPrimaryWhite,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.chat_bubble),
        title: ("Pesan"),
        activeColorPrimary: onPrimaryWhite,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart),
        title: ("Keranjang"),
        activeColorPrimary: onPrimaryWhite,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: onPrimaryWhite,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
