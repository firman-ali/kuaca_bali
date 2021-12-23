import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/detail_page.dart';
import 'package:kuaca_bali/model/list_data_model.dart';
import 'package:kuaca_bali/provider/search_provider.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
      create: (context) => SearchProvider(dbService: DatabaseService()),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Consumer<SearchProvider>(
              builder: (context, snapshot, child) {
                return Column(
                  children: [
                    const PageBar(mainPage: false, title: 'Search'),
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          labelText: 'Cari Disini',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onSubmitted: (value) => snapshot.searchData(value),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Expanded(child: listBuilder(context, snapshot))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget listBuilder(BuildContext context, SearchProvider snapshot) {
    if (snapshot.state == ResultState.hasData) {
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.listData.length,
        itemBuilder: (context, index) =>
            searchItems(context, snapshot.listData[index]),
      );
    } else if (snapshot.state == ResultState.isWaiting) {
      return Center(
        child: Text(
          'Cari Busana Adat',
          style: Theme.of(context).textTheme.caption,
        ),
      );
    } else if (snapshot.state == ResultState.noData) {
      return Center(
        child: Text(
          'Data yang dicari tidak ditemukan',
          style: Theme.of(context).textTheme.caption,
        ),
      );
    } else if (snapshot.state == ResultState.isError) {
      return Center(
        child: Text(
          'Terjadi Error',
          style: Theme.of(context).textTheme.caption,
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget searchItems(BuildContext context, ListDress dressData) {
    return InkWell(
      onTap: () => pushNewScreen(
        context,
        screen: DetailPage(dressId: dressData.id, imageUrl: dressData.imageUrl),
        withNavBar: false,
      ),
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      dressData.imageUrl,
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250,
                            height: 25,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dressData.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: orangeButton),
                              Text(
                                dressData.rating.toString(),
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.store,
                          ),
                          Expanded(
                            child: Text(
                              dressData.storeName!,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          )
                        ],
                      ),
                      Text(
                        CurrencyHelper.format(dressData.price),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
