import 'package:kuaca_bali/model/user_data_model.dart';

class ListDress {
  late String id;
  late String name;
  late String imageUrl;
  late String sellerName;
  late String? storeName;
  late String? storeAddress;
  late double rating;
  late int price;

  ListDress.fromObject(dynamic data, UserData seller) {
    id = data.id;
    name = data['name'];
    imageUrl = data['imageUrl'];
    rating = data['rating'].toDouble();
    price = data['price'].toInt();
    sellerName = seller.name;
    storeName = seller.storeName;
    storeAddress = seller.storeAddress;
  }
}
