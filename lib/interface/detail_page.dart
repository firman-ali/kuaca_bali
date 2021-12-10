import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/provider/detail_dress_data_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.dressId}) : super(key: key);
  final String dressId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailDataProvider>(
      create: (_) =>
          DetailDataProvider(dbService: DatabaseService(), dressId: dressId),
      child: Scaffold(
        body: SingleChildScrollView(
          child:
              Consumer<DetailDataProvider>(builder: (context, snapshot, child) {
            if (snapshot.state == ResultState.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              final detailData = snapshot.data;
              return Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        detailData.imageUrl,
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: secondary700,
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                  padding: EdgeInsets.only(left: 10),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: onSecondary,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: secondary700,
                                    borderRadius: BorderRadius.circular(100)),
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
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  detailData.name,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: primary300,
                                      size: 30,
                                    ),
                                    Text(
                                      detailData.rating.toString(),
                                      style:
                                          Theme.of(context).textTheme.headline2,
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
                                    Icon(
                                      Icons.store,
                                      color: primary300,
                                    ),
                                    Text(
                                      detailData.storeName!,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: primary300,
                                    ),
                                    Text(
                                      detailData.storeAddress!,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  CurrencyHelper.format(detailData.price),
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  "/Hari",
                                  style: Theme.of(context).textTheme.headline3,
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          height: 120.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Kontak Pemilik',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
                                        radius: 25,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        detailData.sellerName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.chat,
                                      color: Colors.blue,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detail',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              detailData.description,
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
