import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/helper/date_helper.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/detail_page.dart';
import 'package:kuaca_bali/interface/payment_page.dart';
import 'package:kuaca_bali/model/cart_data.dart';
import 'package:kuaca_bali/provider/cart_provider.dart.dart';
import 'package:kuaca_bali/widget/menu_button.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(
          children: [
            const PageBar(
              mainPage: true,
              title: 'Keranjang',
              menuButton: MenuButtonCart(),
            ),
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context, snapshot, child) {
                  if (snapshot.state == ResultState.hasData) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 5.0),
                      itemBuilder: (context, index) {
                        return cartitem(
                            context, snapshot.cartList[index], snapshot);
                      },
                      itemCount: snapshot.cartList.length,
                    );
                  } else if (snapshot.state == ResultState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.state == ResultState.noData) {
                    return const Center(child: Text("No Data"));
                  } else {
                    return const Center(child: Text("Error"));
                  }
                },
              ),
            ),
            Consumer<CartProvider>(builder: (context, snapshot, child) {
              if (snapshot.state == ResultState.hasData) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final listCartId =
                          Provider.of<CartProvider>(context, listen: false)
                              .cartList;
                      pushNewScreen(
                        context,
                        screen: PaymentPage(
                          cartId: listCartId.map((e) => e.cartId).toList(),
                        ),
                        withNavBar: false,
                      );
                    },
                    child: const Text('Bayar Pesanan'),
                  ),
                );
              }
              return const SizedBox();
            })
          ],
        ),
      ),
    );
  }

  Widget cartitem(
      BuildContext context, CartData cartData, CartProvider snapshot) {
    return InkWell(
      onTap: () => pushNewScreen(
        context,
        screen:
            DetailPage(dressId: cartData.dressId, imageUrl: cartData.imageUrl),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade,
      ),
      child: SizedBox(
        height: 120.0,
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
            const SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 15),
                      const SizedBox(width: 5.0),
                      Text(
                        DateHelper.formatDateRange(cartData.orderPeriod),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Text(
                    cartData.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.store, size: 20),
                      const SizedBox(width: 5.0),
                      Text(
                        cartData.storeName,
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                  Text(
                    CurrencyHelper.format(cartData.price),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: primary600,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    cartData.size.characters.first,
                    style: const TextStyle(color: onSecondary),
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      await snapshot.removeCart(cartData.cartId);
                      snapshot.fetchCartList();
                    },
                    icon: const Icon(
                      CupertinoIcons.trash,
                      color: primary300,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
