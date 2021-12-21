import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/helper/date_helper.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/review_page.dart';
import 'package:kuaca_bali/model/order_history.dart';
import 'package:kuaca_bali/provider/cart_provider.dart.dart';
import 'package:kuaca_bali/provider/order_history_provider.dart';
import 'package:kuaca_bali/widget/custom_error_widget.dart';
import 'package:kuaca_bali/widget/loading.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const PageBar(mainPage: false, title: 'Riwayat Pesanan'),
            const SizedBox(height: 10.0),
            Expanded(
              child: Consumer<OrderHistoryProvider>(
                  builder: (context, snapshot, child) {
                if (snapshot.state == ResultState.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return historyItem(context, snapshot.orderList[index]);
                    },
                    itemCount: snapshot.orderList.length,
                  );
                } else if (snapshot.state == ResultState.isLoading) {
                  return const LoadingWidget();
                } else if (snapshot.state == ResultState.noData) {
                  return const CustomError(errorStatus: Status.empty);
                } else {
                  return const CustomError(errorStatus: Status.error);
                }
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget historyItem(BuildContext context, OrderHistory orderItem) {
    final _orderPeriod = DateTimeRange(
      start: DateTime.parse(orderItem.orderPeriod.split(' - ').first),
      end: DateTime.parse(orderItem.orderPeriod.split(' - ').last),
    );

    final orderStatus = DateHelper.timeStatus(orderItem.orderPeriod);

    return InkWell(
      onTap: () {
        print(orderItem.reviewStatus);
        if (orderStatus == 'Selesai' && orderItem.reviewStatus == false) {
          pushNewScreen(
            context,
            screen: ReviewPage(
              orderItem: orderItem,
            ),
          );
        }
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  orderItem.dresssImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: primary300,
                            size: 20,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            DateHelper.formatDateRange(_orderPeriod),
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
                          avatar[orderItem.size],
                          style: const TextStyle(color: onSecondary),
                        ),
                      )
                    ],
                  ),
                  Text(orderItem.dressName),
                  Row(
                    children: [
                      const Icon(Icons.store, color: primary300, size: 20),
                      const SizedBox(width: 5.0),
                      Text(
                        orderItem.storeName ?? " Toko ",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        CurrencyHelper.format(
                            orderItem.price * _orderPeriod.duration.inDays),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: secondary300,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          orderStatus,
                          style: const TextStyle(color: onSecondary),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
