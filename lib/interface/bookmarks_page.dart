import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/list_data_model.dart';
import 'package:kuaca_bali/provider/bookmark_provider.dart';
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const PageBar(mainPage: true, title: 'Bookmarks'),
            Expanded(
              child: Consumer<BookmarkProvider>(
                  builder: (context, snapshot, child) {
                if (snapshot.state == ResultState.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return keranjangitem(context, snapshot.listData[index]);
                    },
                    itemCount: snapshot.listData.length,
                  );
                } else if (snapshot.state == ResultState.noData) {
                  return const Text('No Data');
                } else if (snapshot.state == ResultState.isLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return const Text('Error');
                }
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget keranjangitem(BuildContext context, ListDress data) {
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
        padding: const EdgeInsets.all(10.0),
        height: 140,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                data.imageUrl,
                width: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  data.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.store,
                      color: primary300,
                      size: 20,
                    ),
                    Text(
                      data.storeName!,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: primary300,
                      size: 20,
                    ),
                    Text(
                      data.storeAddress!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Text(
                  CurrencyHelper.format(data.price) + "/Hari",
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
