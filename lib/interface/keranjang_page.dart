import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/helper/date_range_format_helper.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/detail_page.dart';
import 'package:kuaca_bali/model/cart_data.dart';
import 'package:kuaca_bali/provider/cart_provider.dart.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const PageBar(mainPage: true, title: 'Keranjang'),
            Expanded(
              child:
                  Consumer<CartProvider>(builder: (context, snapshot, child) {
                if (snapshot.state == ResultState.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return keranjangitem(context, snapshot.cartList[index]);
                    },
                    itemCount: 1,
                  );
                } else if (snapshot.state == ResultState.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.state == ResultState.noData) {
                  return const Center(child: Text("No Data"));
                } else {
                  return const Center(child: Text("Error"));
                }
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget keranjangitem(BuildContext context, CartData cartData) {
    return InkWell(
      onTap: () => pushNewScreen(
        context,
        screen:
            DetailPage(dressId: cartData.dressId, imageUrl: cartData.imageUrl),
        withNavBar: false,
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: 130.0,
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  cartData.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 20,
                            color: primary300,
                          ),
                          Text(
                            DateRangeHelper.format(cartData.orderPeriod),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: secondary300,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          avatar[cartData.size],
                          style: const TextStyle(color: onSecondary),
                        ),
                      )
                    ],
                  ),
                  Text(
                    cartData.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.store,
                        color: primary300,
                        size: 20,
                      ),
                      Text(
                        cartData.storeName,
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                  Text(
                    CurrencyHelper.format(cartData.price),
                    style: Theme.of(context).textTheme.headline5,
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
