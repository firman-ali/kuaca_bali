import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
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
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: onBackground),
                      ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          mainPage && menuButton != null ? menuButton! : const SizedBox()
        ],
      ),
    );
  }
}
