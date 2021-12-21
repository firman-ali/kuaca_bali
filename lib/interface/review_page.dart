import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/date_helper.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/order_history.dart';
import 'package:kuaca_bali/provider/auth_provider.dart';
import 'package:kuaca_bali/provider/cart_provider.dart.dart';
import 'package:kuaca_bali/provider/order_history_provider.dart';
import 'package:kuaca_bali/provider/review_provider.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key, required this.orderItem}) : super(key: key);

  final OrderHistory orderItem;

  static final TextEditingController _reviewController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReviewProvider>(
      create: (context) => ReviewProvider(
          dbService: DatabaseService(),
          authService: AuthService(),
          orderData: orderItem),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const PageBar(mainPage: false, title: 'Review'),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pesananmu :',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            height: 100,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      orderItem.dresssImageUrl,
                                      width: 110,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_today,
                                                color: primary300,
                                                size: 20,
                                              ),
                                              Text(
                                                DateHelper.formatDateRange(
                                                  DateTimeRange(
                                                    start: DateTime.parse(
                                                        orderItem.orderPeriod
                                                            .split(' - ')
                                                            .first),
                                                    end: DateTime.parse(
                                                        orderItem.orderPeriod
                                                            .split(' - ')
                                                            .last),
                                                  ),
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              )
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 5.0),
                                            decoration: BoxDecoration(
                                              color: secondary300,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Text(
                                              avatar[orderItem.size],
                                              style: const TextStyle(
                                                  color: onSecondary),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            orderItem.dressName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.store,
                                            color: primary300,
                                            size: 23,
                                          ),
                                          Text(
                                            orderItem.storeName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          )
                                        ],
                                      ),
                                      Text(
                                        CurrencyHelper.format(orderItem.price *
                                            DateTimeRange(
                                              start: DateTime.parse(orderItem
                                                  .orderPeriod
                                                  .split(' - ')
                                                  .first),
                                              end: DateTime.parse(orderItem
                                                  .orderPeriod
                                                  .split(' - ')
                                                  .last),
                                            ).duration.inDays),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: List.generate(
                          150 ~/ 5,
                          (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.grey
                                  : Colors.transparent,
                              height: 5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Berikan Review',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Consumer<ReviewProvider>(
                              builder: (context, snapshot, child) {
                            return RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                snapshot.setStarPoint = rating;
                              },
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _reviewController,
                        showCursor: true,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Tulis Review',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.all(10.0),
                        ),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: MediaQuery.of(context).size.width,
            child: Consumer<ReviewProvider>(
              builder: (context, snapshot, child) {
                return ElevatedButton(
                  onPressed: () async {
                    final userName =
                        Provider.of<AuthProvider>(context, listen: false)
                            .user
                            .name;
                    if (snapshot.starPoint < 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Berikan Bintang Dari Item Ini'),
                        ),
                      );
                    } else {
                      await snapshot.addReview(
                          _reviewController.text, userName);
                      if (snapshot.state == ResultState.isSuccess) {
                        Provider.of<OrderHistoryProvider>(context,
                                listen: false)
                            .refreshData();
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text('Tambahkan Review'),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10.0)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
