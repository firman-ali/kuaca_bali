import 'package:cloud_firestore/cloud_firestore.dart';

class AddDressData {
  late String dressName;
  late String description;
  late String imageUrl;
  late int price;
  late List<String?> listSize;
  late String sellerId;
  late Timestamp createdAt;
  late Timestamp updatedAt;
  late double? rating;

  AddDressData({
    required this.dressName,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.listSize,
    required this.sellerId,
    required this.createdAt,
    required this.updatedAt,
    this.rating,
  });

  Map<String, dynamic> toObject() => {
        "name": dressName,
        "description": description,
        "imageUrl": imageUrl,
        "price": price,
        "rating": rating,
        "listSize": listSize,
        "sellerId": sellerId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
