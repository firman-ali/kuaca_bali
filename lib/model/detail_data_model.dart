import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuaca_bali/model/user_data_model.dart';

class DressDataElement {
  late String id;
  late String name;
  late String imageUrl;
  late String? sellerName;
  late String? storeName;
  late String? storeAddress;
  late Timestamp? sellerRegisterAt;
  late String description;
  late double rating;
  late int price;

  late Timestamp createdAt;
  late Timestamp updatedAt;

  DressDataElement.fromObject(
      DocumentSnapshot<Map<String, dynamic>> data, UserData seller) {
    id = data.id;
    name = data['name'];
    imageUrl = data['imageUrl'];
    description = data['description'];
    rating = data['rating'].toDouble();
    price = data['price'].toInt();
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
    sellerName = seller.name;
    storeName = seller.storeName;
    storeAddress = seller.storeAddress;
    sellerRegisterAt = seller.sellerRegisterAt;
  }
}
