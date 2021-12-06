import 'package:cloud_firestore/cloud_firestore.dart';

class DressData {
  late String id;
  late String name;
  late String imageUrl;
  late String storeName;
  late double rating;
  late int price;

  DressData.fromObject(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    name = data['name'];
    imageUrl = data['imageUrl'];
    storeName = data['storeName'];
    rating = data['rating'].toDouble();
    price = data['price'].toInt();
  }
}
