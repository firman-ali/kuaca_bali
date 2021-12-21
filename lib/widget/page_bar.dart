import 'package:flutter/material.dart';

class PageBar extends StatelessWidget {
  const PageBar(
      {Key? key, required this.mainPage, required this.title, this.menuButton})
      : super(key: key);

  final bool mainPage;
  final String title;
  final Widget? menuButton;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              mainPage
                  ? const SizedBox()
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
          mainPage && menuButton != null ? menuButton! : const SizedBox()
        ],
      ),
    );
  }
}
