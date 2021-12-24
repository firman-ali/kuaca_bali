import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/chat_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/chat_room_page.dart';
import 'package:kuaca_bali/interface/order_page.dart';
import 'package:kuaca_bali/model/detail_data_model.dart';
import 'package:kuaca_bali/provider/bookmark_provider.dart';
import 'package:kuaca_bali/provider/detail_dress_data_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.dressId, required this.imageUrl})
      : super(key: key);
  final String dressId;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DetailDataProvider>(
          create: (_) => DetailDataProvider(
              dbService: DatabaseService(), dressId: dressId),
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  imageUrl,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.cover,
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
                      detailData.listReview.isNotEmpty
                          ? reviewBodyList(detailData.listReview)
                          : SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  child: ListTile(
                                    style: ListTileStyle.drawer,
                                    title: Text(
                                      'Belum Ada Review',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                );
              }
            }),
          ],
        ),
        bottomNavigationBar: bottomBar(context),
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Consumer<DetailDataProvider>(
        builder: (context, snapshot, child) {
          if (snapshot.state == ResultState.hasData) {
            return Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Harga Mulai",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5.0),
                      FittedBox(
                        child: Text(
                          CurrencyHelper.format(snapshot.data.price) + "/Hari",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showOrderPage(context, snapshot.data);
                    },
                    child: const Text('Pesan Sekarang'),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Future<dynamic> showOrderPage(
      BuildContext context, DressDataElement dressData) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      context: context,
      builder: (context) {
        return OrderPage(
          dress: dressData,
        );
      },
    );
  }

  Widget reviewBodyList(List<ListItemReview> listReview) {
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                title: Text(
                  listReview[index].userName,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  listReview[index].msg,
                  style: Theme.of(context).textTheme.subtitle2,
                  maxLines: 10,
                ),
                trailing: SizedBox(
                  width: 60,
                  height: 50,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: orangeButton,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        listReview[index].starPoint.toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          childCount: listReview.length,
        ),
      ),
    );
  }

  Widget reviewTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text("Review", style: Theme.of(context).textTheme.headline6),
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
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10.0),
            Text(
              description,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }

  Widget sellerCard(BuildContext context, DressDataElement detailData) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kontak Pemilik',
              style: Theme.of(context).textTheme.headline6,
            ),
            Material(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(detailData.sellerImageUrl ??
                      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
                  radius: 25,
                ),
                title: Text(
                  detailData.sellerName!,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: detailData.sellerId != AuthService().getUserId()
                    ? IconButton(
                        onPressed: () async {
                          String? roomId = await ChatService().getRoomFromUser(
                              detailData.sellerId, AuthService().getUserId()!);
                          final frienData = await ChatService()
                              .getFriendData(detailData.sellerId);
                          if (roomId != null) {
                            await ChatService().readMsg(
                                AuthService().getUserId()!,
                                roomId,
                                detailData.sellerId);
                            pushNewScreen(
                              context,
                              screen: ChatRoomPage(
                                roomId: roomId,
                                friendData: frienData,
                              ),
                              withNavBar: false,
                            );
                          } else {
                            roomId = await ChatService().createRoomChat(
                                AuthService().getUserId()!,
                                detailData.sellerId);
                            pushNewScreen(
                              context,
                              screen: ChatRoomPage(
                                roomId: roomId,
                                friendData: frienData,
                              ),
                              withNavBar: false,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.chat,
                          color: secondary,
                        ),
                      )
                    : null,
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
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        detailData.name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: orangeButton,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          detailData.rating.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: Row(
                children: [
                  const Icon(Icons.store),
                  Text(
                    detailData.storeName!,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: Row(
                children: [
                  const Icon(Icons.location_on),
                  Expanded(
                    child: Text(
                      detailData.storeAddress!,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
            ),
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
              backgroundColor: surface,
              child: IconButton(
                padding: const EdgeInsets.only(left: 10),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: onSurface,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: surface,
              child: Consumer<BookmarkProvider>(
                builder: (context, snapshot, child) {
                  if (snapshot.status) {
                    return IconButton(
                      onPressed: () {
                        snapshot.removeBookmark(dressId);
                      },
                      icon: const Icon(
                        Icons.bookmark,
                        color: selectedButton,
                      ),
                    );
                  } else {
                    return IconButton(
                      onPressed: () {
                        snapshot.addBookmark(dressId);
                      },
                      icon: const Icon(
                        Icons.bookmark,
                        color: unSelectedButton,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
