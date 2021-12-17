import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/detail_page.dart';
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
            height: MediaQuery.of(context).size.height / 2.5,
            color: primary600.withOpacity(0.15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const HomeBar(),
                const SizedBox(height: 20),
                Consumer<HomeProvider>(
                  builder: (context, snapshot, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MultiSelectChipDisplay<Map<String, String>>(
                            height: 50,
                            scroll: true,
                            items: snapshot.filterSelected
                                .map((e) => MultiSelectItem(e, e.values.first))
                                .toList(),
                          ),
                        ),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                              color: surface,
                              borderRadius: BorderRadius.circular(10)),
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
                ),
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
                                  const SizedBox(height: 20),
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

  void _showMultiSelect(BuildContext context, HomeProvider provider) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog<Map<String, String>>(
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
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          alignment: Alignment.centerRight,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {},
          iconSize: 30,
          icon: const Icon(
            Icons.arrow_back,
            textDirection: TextDirection.rtl,
          ),
        )
      ],
    );
  }

  Widget gridItemWidget(
      BuildContext context, HomeProvider snapshot, int index) {
    return InkWell(
      onTap: () {
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
          color: surface,
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
                    child: Hero(
                      tag: snapshot.listData[index].id,
                      child: Image.network(
                        snapshot.listData[index].imageUrl,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: secondary700.withOpacity(0.8),
                      radius: 18,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.bookmark,
                            size: 20,
                            color: onSecondary,
                          )),
                    ),
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
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.star,
                              color: primary300,
                              size: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              snapshot.listData[index].rating.toString(),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
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
                            const Icon(Icons.store, color: primary300),
                            Expanded(
                              child: Text(
                                snapshot.listData[index].storeName!,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: Text(
                          CurrencyHelper.format(snapshot.listData[index].price),
                          style: Theme.of(context).textTheme.bodyText2,
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
