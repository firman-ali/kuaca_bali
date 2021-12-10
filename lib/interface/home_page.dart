import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/provider/list_data_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, bottom: 25.0, top: 10),
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
                              final userData = snapshot.user;
                              final dataName = userData.name
                                  .split(" ")
                                  .map((e) => e)
                                  .toList();
                              late String name;
                              if (dataName.elementAt(0).length > 2) {
                                name = dataName.elementAt(0);
                              } else {
                                name = dataName.elementAt(1);
                              }
                              return Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      userData.imageUrl!,
                                      fit: BoxFit.cover,
                                      width: 50.0,
                                      height: 50.0,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Welcome, ' + name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
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
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            switch (value) {
                              case "Logout":
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .signOut();
                                break;
                              default:
                            }
                          },
                          color: surface,
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
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Consumer<ListDataProvider>(
                builder: (context, snapshot, child) {
                  if (snapshot.state == ResultState.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.state == ResultState.hasData) {
                    final listData = snapshot.listData;
                    return GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: listData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      listData[index].imageUrl,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: CircleAvatar(
                                      backgroundColor: secondary700,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.bookmark,
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
                                  Text(listData[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.store, color: primary300),
                                          Text(
                                            listData[index].storeName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            CurrencyHelper.format(
                                                listData[index].price),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Text(
                                            "/Hari",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('Error'),
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
