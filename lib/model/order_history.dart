import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuaca_bali/model/list_data_model.dart';

class OrderHistory {
  late String orderId;
  late String dressId;
  late String? storeName;
  late String dresssImageUrl;
  late String dressName;
  late int price;
  late int size;
  late String orderPeriod;
  late String paymentMethod;
  late Timestamp orderedAt;
  late bool reviewStatus;

  OrderHistory({
    required this.orderId,
    required this.dressId,
    required this.storeName,
    required this.dresssImageUrl,
    required this.dressName,
    required this.price,
    required this.size,
    required this.orderPeriod,
    required this.paymentMethod,
    required this.orderedAt,
    required this.reviewStatus,
  });

  OrderHistory.fromObject(
    DocumentSnapshot<Map<String, dynamic>> dataOrder,
    QueryDocumentSnapshot<Map<String, dynamic>> dataItems,
    ListDress dreesData,
  ) {
    orderId = dataOrder.id;
    dressId = dreesData.id;
    paymentMethod = dataOrder['paymentMethod'];
    dressName = dreesData.name;
    dresssImageUrl = dreesData.imageUrl;
    orderPeriod = dataItems['orderPeriod'];
    size = dataItems['size'].toInt();
    price = dreesData.price;
    storeName = dreesData.storeName;
    orderedAt = dataOrder['orderedAt'];
    reviewStatus = dataItems['reviewStatus'];
  }
}
