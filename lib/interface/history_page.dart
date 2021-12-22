import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/date_helper.dart';
import 'package:kuaca_bali/helper/format_currency_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/review_page.dart';
import 'package:kuaca_bali/model/order_history.dart';
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
    return ChangeNotifierProvider<OrderHistoryProvider>(
      create: (context) => OrderHistoryProvider(
          dbService: DatabaseService(), authService: AuthService()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            children: [
              const PageBar(mainPage: false, title: 'Riwayat Pesanan'),
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
        height: 110,
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
                            size: 20,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            DateHelper.formatDateRange(_orderPeriod),
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: primary600,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          orderItem.size.characters.first,
                          style: const TextStyle(color: onSecondary),
                        ),
                      )
                    ],
                  ),
                  Text(
                    orderItem.dressName,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.store, size: 20),
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
                        CurrencyHelper.format(orderItem.price *
                            (_orderPeriod.duration.inDays > 0
                                ? _orderPeriod.duration.inDays
                                : 1)),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: primary600,
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
