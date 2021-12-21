import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/chat_service.dart';
import 'package:kuaca_bali/interface/history_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/provider/bookmark_provider.dart';
import 'package:kuaca_bali/provider/cart_provider.dart.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class MenuButtonHome extends StatelessWidget {
  const MenuButtonHome({
    Key? key,
  }) : super(key: key);

  static Set<String> item = {'Riwayat Pesanan', 'Logout'};

  @override
  Widget build(BuildContext context) {
    return PopMenuButton(item: item);
  }
}

class MenuButtonBookmark extends StatelessWidget {
  const MenuButtonBookmark({Key? key}) : super(key: key);

  static Set<String> item = {'Bersihkan Bookmark', 'Logout'};

  @override
  Widget build(BuildContext context) {
    return PopMenuButton(item: item);
  }
}

class MenuButtonChat extends StatelessWidget {
  const MenuButtonChat({Key? key}) : super(key: key);

  static Set<String> item = {'Bersihkan Pesan', 'Logout'};

  @override
  Widget build(BuildContext context) {
    return PopMenuButton(item: item);
  }
}

class MenuButtonCart extends StatelessWidget {
  const MenuButtonCart({Key? key}) : super(key: key);

  static Set<String> item = {
    'Riwayat Pesanan',
    'Bersihkan Keranjang',
    'Logout'
  };

  @override
  Widget build(BuildContext context) {
    return PopMenuButton(item: item);
  }
}

class PopMenuButton extends StatelessWidget {
  const PopMenuButton({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Set<String> item;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case "Bersihkan Bookmark":
            Provider.of<BookmarkProvider>(context, listen: false)
                .clearBookmark();
            break;
          case "Bersihkan Pesan":
            ChatService().clearChatRoom();
            break;
          case "Bersihkan Keranjang":
            Provider.of<CartProvider>(context, listen: false)
                .clearCartList(AuthService().getUserId()!);
            break;
          case "Riwayat Pesanan":
            pushNewScreen(context,
                screen: const HistoryPage(), withNavBar: false);
            break;
          case "Logout":
            Provider.of<AuthProvider>(context, listen: false).signOut();
            break;
          default:
        }
      },
      color: surface,
      icon: const Icon(
        Icons.more_vert,
        color: onSurface,
      ),
      iconSize: 35,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context) {
        return item.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
