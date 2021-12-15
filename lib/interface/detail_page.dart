import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/detail_data_model.dart';
import 'package:kuaca_bali/provider/detail_dress_data_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.dressId, required this.imageUrl})
      : super(key: key);
  final String dressId;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailDataProvider>(
      create: (_) =>
          DetailDataProvider(dbService: DatabaseService(), dressId: dressId),
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: dressId,
                  child: Image.network(
                    imageUrl,
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                buttonAppBar(context),
              ],
            ),
            Consumer<DetailDataProvider>(builder: (context, snapshot, child) {
              if (snapshot.state == ResultState.isLoading) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              } else {
                final detailData = snapshot.data;
                return Expanded(
                  child: CustomScrollView(
                    slivers: [
                      bodyHeader(detailData, context),
                      sellerCard(context, detailData),
                      detailBody(context, detailData.description),
                      reviewTitle(context),
                      reviewBody(detailData.listReview)
                    ],
                  ),
                );
              }
            }),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    context: context,
                    builder: (context) {
                      return Container(
                        //height: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 35.0,
                                  ),
                                  Text(
                                    'Durasi Pemesanan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: Icon(Icons.shopping_cart)),
                                  Padding(
                                    padding: const EdgeInsets.all(150.0),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text('Lanjutkan Pesanan')),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Text('Pesan Sekarang')),
        ),
      ),
    );
  }

  Widget reviewBody(List<ListItemReview> listReview) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: ListTile(
                        title: Text(listReview[index].userName),
                        subtitle: Text(listReview[index].review),
                        trailing: SizedBox(
                          width: 60,
                          height: 50,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: primary300,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                listReview[index].starPoint.toString(),
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              childCount: listReview.length)),
    );
  }

  Widget reviewTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text("Review", style: Theme.of(context).textTheme.headline3),
      ),
    );
  }

  Widget detailBody(BuildContext context, String description) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }

  Widget sellerCard(BuildContext context, DressDataElement detailData) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kontak Pemilik',
              style: Theme.of(context).textTheme.headline3,
            ),
            Material(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
                  radius: 25,
                ),
                title: Text(
                  detailData.sellerName!,
                  style: Theme.of(context).textTheme.headline5,
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chat,
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bodyHeader(DressDataElement detailData, BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  detailData.name,
                  style: Theme.of(context).textTheme.headline2,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: primary300,
                    ),
                    Text(
                      detailData.rating.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.store,
                      color: primary300,
                    ),
                    Text(
                      detailData.storeName!,
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: primary300,
                    ),
                    Text(
                      detailData.storeAddress!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  CurrencyHelper.format(detailData.price),
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  "/Hari",
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buttonAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: secondary700.withOpacity(0.8),
              child: IconButton(
                padding: const EdgeInsets.only(left: 10),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: onSecondary,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: secondary700.withOpacity(0.8),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark,
                  color: onSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
