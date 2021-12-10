import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuaca_bali/model/user_data_model.dart';

class ListDress {
  late String id;
  late String name;
  late String imageUrl;
  late String sellerName;
  late String? storeName;
  late double rating;
  late String size;
  late int price;

  ListDress.fromObject(
      QueryDocumentSnapshot<Map<String, dynamic>> data, UserData seller) {
    id = data.id;
    name = data['name'];
    imageUrl = data['imageUrl'];
    rating = data['rating'].toDouble();
    price = data['price'].toInt();
    size = data['size'];
    sellerName = seller.name;
    storeName = seller.storeName;
  }
}
