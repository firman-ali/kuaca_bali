import 'package:flutter/material.dart';
import 'menu_button.dart';

class PageBar extends StatelessWidget {
  const PageBar({Key? key, required this.mainPage, required this.title})
      : super(key: key);

  final bool mainPage;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              mainPage
                  ? Container()
                  : IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      iconSize: 35,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
          const MenuButton()
        ],
      ),
    );
  }
}
