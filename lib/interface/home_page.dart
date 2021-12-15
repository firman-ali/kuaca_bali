import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/detail_page.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/provider/list_data_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          appBarWidget(context),
          Expanded(
            child: Consumer<ListDataProvider>(
              builder: (context, snapshot, child) {
                if (snapshot.state == ResultState.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.state == ResultState.hasData) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: titleBarWidget(context, snapshot),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(10.0),
                        sliver: SliverGrid(
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
                          ),
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
    );
  }

  Widget titleBarWidget(BuildContext context, ListDataProvider snapshot) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Cari Busana Adat Impianmu',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Expanded(child: listFilterButton(snapshot, context))
        ],
      ),
    );
  }

  Widget listFilterButton(ListDataProvider snapshot, BuildContext context) {
    List<String> sort = [
      'Semua',
      'Produk Terbaru',
      'Produk Terlama',
      'Nama A-Z',
      'Nama Z-A',
      'Harga Termurah',
      'Harga Termahal'
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
      decoration: BoxDecoration(
        color: secondary700,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          alignment: AlignmentDirectional.center,
          hint: Text(
            snapshot.sort,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: onSecondary),
          ),
          icon: const Icon(Icons.filter_alt),
          iconSize: 18,
          iconEnabledColor: onSecondary,
          items: sort.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyText2,
                ));
          }).toList(),
          onChanged: (value) async {
            await Provider.of<ListDataProvider>(context, listen: false)
                .fetchDataSorting(value!);
          },
        ),
      ),
    );
  }

  Widget appBarWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, bottom: 25.0, top: 15.0),
      decoration: const BoxDecoration(
        color: primary300,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<AuthProvider>(
                  builder: (context, snapshot, child) {
                    if (snapshot.isSignIn &&
                        snapshot.state == ResultState.finished) {
                      return Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: snapshot.user.imageUrl != null
                                ? Image.network(
                                    snapshot.user.imageUrl!,
                                    fit: BoxFit.cover,
                                    width: 50.0,
                                    height: 50.0,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/julian-wan-WNoLnJo7tS8-unsplash.jpg',
                                      width: 50.0,
                                      height: 50.0,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Welcome, ' + snapshot.name!,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: onPrimaryWhite),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/julian-wan-WNoLnJo7tS8-unsplash.jpg',
                              width: 50.0,
                              height: 50.0,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Welcome, User',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(color: onPrimaryWhite),
                          ),
                        ],
                      );
                    }
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 35,
                        color: onPrimaryWhite,
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        switch (value) {
                          case "Logout":
                            Provider.of<AuthProvider>(context, listen: false)
                                .signOut();
                            break;
                          default:
                        }
                      },
                      color: onPrimaryWhite,
                      icon: const Icon(
                        Icons.more_vert,
                        color: onPrimaryWhite,
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
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget gridItemWidget(
      BuildContext context, ListDataProvider snapshot, int index) {
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
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            snapshot.listData[index].rating.toString(),
                            style: Theme.of(context).textTheme.caption,
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
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
