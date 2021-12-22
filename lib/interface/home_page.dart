import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/detail_page.dart';
import 'package:kuaca_bali/provider/bookmark_provider.dart';
import 'package:kuaca_bali/provider/home_provider.dart';
import 'package:kuaca_bali/widget/home_bar.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5.5,
            color: primary600.withOpacity(0.15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const HomeBar(),
                const SizedBox(height: 15),
                filterBody(),
                const SizedBox(height: 10),
                Expanded(
                  child: Consumer<HomeProvider>(
                    builder: (context, snapshot, child) {
                      if (snapshot.state == ResultState.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.state == ResultState.hasData) {
                        return CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  titleBarWidget(context),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) =>
                                    gridItemWidget(context, snapshot, index),
                                childCount: snapshot.listData.length,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 20.0,
                                childAspectRatio: 0.8,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text('Error'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget filterBody() {
    return Consumer<HomeProvider>(
      builder: (context, snapshot, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: filterDisplay(context, snapshot),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              decoration: BoxDecoration(
                  color: surface, borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () {
                  _showMultiSelect(context, snapshot);
                },
                icon: const Icon(CupertinoIcons.sort_down),
              ),
            )
          ],
        );
      },
    );
  }

  Widget filterDisplay(BuildContext context, HomeProvider snapshot) {
    return MultiSelectChipDisplay<Map<String, String>>(
      height: 50,
      scroll: true,
      textStyle:
          Theme.of(context).textTheme.caption?.copyWith(color: secondary),
      items: snapshot.filterSelected
          .map((e) => MultiSelectItem(e, e.values.first))
          .toList(),
    );
  }

  void _showMultiSelect(BuildContext context, HomeProvider provider) async {
    await showDialog(
      context: context,
      builder: (contex) {
        return MultiSelectDialog<Map<String, String>>(
          title: Text(
            'Pilih Kategori Filter',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          searchHint: 'Cari Kategori Filter',
          height: 200,
          items: provider.filterItem
              .map((e) =>
                  MultiSelectItem<Map<String, String>>(e, e.values.first))
              .toList(),
          initialValue: provider.filterSelected,
          onConfirm: (values) {
            provider.addItemFilter = values;
          },
        );
      },
    );
  }

  Widget titleBarWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Cari Busana Adat Impianmu',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }

  Widget gridItemWidget(
      BuildContext context, HomeProvider snapshot, int index) {
    return InkWell(
      onTap: () async {
        await Provider.of<BookmarkProvider>(context, listen: false)
            .getStatus(snapshot.listData[index].id);
        pushNewScreen(
          context,
          screen: DetailPage(
            dressId: snapshot.listData[index].id,
            imageUrl: snapshot.listData[index].imageUrl,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: primary100.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      snapshot.listData[index].imageUrl,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: BookmarkButton(dressId: snapshot.listData[index].id),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          snapshot.listData[index].name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.star,
                              color: orangeButton,
                              size: 20,
                            ),
                            Text(snapshot.listData[index].rating.toString(),
                                style: Theme.of(context).textTheme.subtitle2),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            const Icon(Icons.store),
                            Expanded(
                              child: Text(
                                snapshot.listData[index].storeName!,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: Text(
                          CurrencyHelper.format(snapshot.listData[index].price),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookmarkButton extends StatefulWidget {
  const BookmarkButton({Key? key, required this.dressId}) : super(key: key);

  final String dressId;
  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await Provider.of<BookmarkProvider>(context, listen: false)
          .getStatus(widget.dressId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkProvider>(
      builder: (context, snapshot, child) {
        return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: DatabaseService()
              .getBookmark(AuthService().getUserId()!, widget.dressId),
          builder: (context, snapshot2) {
            if (snapshot2.data != null && snapshot2.data!.exists) {
              return CircleAvatar(
                backgroundColor: surface,
                radius: 18,
                child: IconButton(
                  onPressed: () async {
                    await Provider.of<BookmarkProvider>(context, listen: false)
                        .removeBookmark(widget.dressId);
                  },
                  icon: const Icon(
                    Icons.bookmark,
                    size: 20,
                    color: selectedButton,
                  ),
                ),
              );
            } else {
              return CircleAvatar(
                backgroundColor: surface,
                radius: 18,
                child: IconButton(
                  onPressed: () async {
                    await Provider.of<BookmarkProvider>(context, listen: false)
                        .addBookmark(widget.dressId);
                  },
                  icon: const Icon(
                    Icons.bookmark,
                    size: 20,
                    color: unSelectedButton,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
