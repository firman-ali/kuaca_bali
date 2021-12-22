import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuaca_bali/model/user_data_model.dart';

class DressDataElement {
  late String id;
  late String name;
  late String imageUrl;
  late String sellerId;
  late String? sellerName;
  late String? sellerImageUrl;
  late String? storeName;
  late String? storeAddress;
  late Timestamp? sellerRegisterAt;
  late String description;
  late double rating;
  late int price;
  late List<dynamic> listSize;
  late List<ListItemReview> listReview;

  late Timestamp createdAt;
  late Timestamp updatedAt;

  DressDataElement.fromObject(DocumentSnapshot<Map<String, dynamic>> data,
      UserData seller, QuerySnapshot<Map<String, dynamic>> reviews) {
    id = data.id;
    name = data['name'];
    imageUrl = data['imageUrl'];
    description = data['description'];
    rating = data['rating'].toDouble();
    price = data['price'].toInt();
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
    sellerId = data['sellerId'];
    sellerName = seller.name;
    sellerImageUrl = seller.imageUrl;
    storeName = seller.storeName;
    storeAddress = seller.storeAddress;
    sellerRegisterAt = seller.sellerRegisterAt;
    listReview = reviews.docs.map((e) => ListItemReview.fromObject(e)).toList();
    listSize = data['listSize'];
  }
}

class ListItemReview {
  late String userName;
  late String msg;
  late String orderId;
  late double starPoint;

  ListItemReview.fromObject(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    userName = data['userName'];
    msg = data['msg'];
    orderId = data['orderId'];
    starPoint = data['starPoint'].toDouble();
  }
}
