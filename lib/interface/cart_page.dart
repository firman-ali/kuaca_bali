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
        padding: const EdgeInsets.all(8.0),
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
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  final listCartId =
                      Provider.of<CartProvider>(context, listen: false)
                          .cartList;
                  if (listCartId.isNotEmpty) {
                    pushNewScreen(
                      context,
                      screen: PaymentPage(
                        cartId: listCartId.map((e) => e.cartId).toList(),
                      ),
                      withNavBar: false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tidak Ada Pesanan Di Keranjang'),
                      ),
                    );
                  }
                },
                child: const Text('Bayar Pesanan'),
                style: ElevatedButton.styleFrom(
                  primary: secondary700,
                  padding: const EdgeInsets.all(10),
                ),
              ),
            )
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
            const SizedBox(width: 5),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: primary300,
                      ),
                      Text(
                        DateHelper.formatDateRange(cartData.orderPeriod),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                ),
                IconButton(
                  onPressed: () async {
                    await snapshot.removeCart(cartData.cartId);
                    snapshot.fetchCartList();
                  },
                  icon: const Icon(
                    CupertinoIcons.trash,
                    color: primary300,
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
