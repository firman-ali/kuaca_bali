import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
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
        return {'Logout'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
