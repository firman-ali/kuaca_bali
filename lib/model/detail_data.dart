import 'package:cloud_firestore/cloud_firestore.dart';

class DressDataElement {
  late String id;
  late String name;
  late String imageUrl;
  late String sellerName;
  late String storeName;
  late String storeAddress;
  late String detail;
  late double rating;
  late int price;
  late Timestamp createdAt;
  late Timestamp updatedAt;

  DressDataElement.fromObject(DocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    name = data['name'];
    imageUrl = data['imageUrl'];
    sellerName = data['sellerName'];
    storeName = data['storeName'];
    storeAddress = data['storeAddress'];
    detail = data['detail'];
    rating = data['rating'].toDouble();
    price = data['price'].toInt();
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }
}
