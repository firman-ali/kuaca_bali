import 'package:flutter/material.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/list_data_model.dart';
import 'package:kuaca_bali/provider/bookmark_provider.dart';
import 'package:kuaca_bali/widget/custom_error_widget.dart';
import 'package:kuaca_bali/widget/loading.dart';
import 'package:kuaca_bali/widget/menu_button.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import 'detail_page.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(
          children: [
            const PageBar(
              mainPage: true,
              title: 'Bookmarks',
              menuButton: MenuButtonBookmark(),
            ),
            Expanded(
              child: Consumer<BookmarkProvider>(
                  builder: (context, snapshot, child) {
                if (snapshot.state == ResultState.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return cartItem(context, snapshot.listData[index]);
                    },
                    itemCount: snapshot.listData.length,
                  );
                } else if (snapshot.state == ResultState.noData) {
                  return const CustomError(errorStatus: Status.empty);
                } else if (snapshot.state == ResultState.isLoading) {
                  return const LoadingWidget();
                } else {
                  return const CustomError(errorStatus: Status.error);
                }
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget cartItem(BuildContext context, ListDress data) {
    return InkWell(
      onTap: () => pushNewScreen(
        context,
        screen: DetailPage(
          dressId: data.id,
          imageUrl: data.imageUrl,
        ),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade,
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 5.0),
        height: 140,
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  data.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    data.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.store, size: 25),
                      const SizedBox(width: 2.0),
                      Text(
                        data.storeName!,
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 20),
                      const SizedBox(width: 5.0),
                      Text(
                        data.storeAddress!,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  Text(
                    CurrencyHelper.format(data.price) + "/Hari",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
