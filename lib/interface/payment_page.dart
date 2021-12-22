import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/date_helper.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/cart_data.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/provider/cart_provider.dart.dart';
import 'package:kuaca_bali/provider/payment_provider.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key, required this.cartId}) : super(key: key);

  final List<String> cartId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PaymentProvider>(
      create: (context) => PaymentProvider(
        dbService: DatabaseService(),
        authService: AuthService(),
        cartId: cartId,
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageBar(mainPage: false, title: 'Pemesanan'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rincian Pesanan',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const SizedBox(height: 10.0),
                              userInformation(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      dottedListGenerator(),
                      const SizedBox(height: 20),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pembayaran',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const SizedBox(height: 10.0),
                              paymentMethodSelector(context),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Detail Pemesanan',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Consumer<PaymentProvider>(
                                      builder: (context, snapshot, child) {
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: snapshot.cartList.length,
                                      itemBuilder: (context, index) {
                                        return cartItems(
                                            context, snapshot.cartList[index]);
                                      },
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              buttomPaymentBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttomPaymentBar(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Consumer<PaymentProvider>(
          builder: (context, snapshot, child) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Pesanan :',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 5),
                      FittedBox(
                        child: Text(
                          CurrencyHelper.format(snapshot.totalPayment),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await snapshot.addOrder();
                      if (snapshot.state == ResultState.isSuccess) {
                        Provider.of<CartProvider>(context, listen: false)
                            .fetchCartList();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Bayar Sekarang'),
                  ),
                ),
              ],
            );
          },
        ));
  }

  Widget paymentMethodSelector(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, snapshot, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Metode Pembayaran :',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      'Transfer',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    leading: Radio<String>(
                      value: 'Transfer',
                      groupValue: snapshot.paymentMethod,
                      onChanged: (String? value) {
                        if (value != null) {
                          snapshot.setPaymentMethod = value;
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      'COD',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    leading: Radio<String>(
                      value: 'COD',
                      groupValue: snapshot.paymentMethod,
                      onChanged: (String? value) {
                        if (value != null) {
                          snapshot.setPaymentMethod = value;
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget userInformation() {
    return Consumer<AuthProvider>(
      builder: (context, snapshot, child) {
        return SizedBox(
          height: 60,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  snapshot.user.imageUrl ??
                      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    snapshot.user.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.home, color: primary300),
                      Text(
                        snapshot.user.address,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget cartItems(BuildContext context, CartData cartData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      cartData.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: primary300,
                            size: 20,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            DateHelper.formatDateRange(cartData.orderPeriod),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      Text(
                        cartData.name,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
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
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.house,
                            color: primary300,
                            size: 20,
                          ),
                          Text(
                            cartData.storeAddress,
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                      Text(
                        CurrencyHelper.format(cartData.price) + '/Hari',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dottedListGenerator() {
    return Row(
      children: List.generate(
        100 ~/ 3,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.grey : Colors.transparent,
            height: 5,
          ),
        ),
      ),
    );
  }
}
