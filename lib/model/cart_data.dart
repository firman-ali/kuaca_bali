import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartData {
  late String cartId;
  late String dressId;
  late String name;
  late String imageUrl;
  late Timestamp addedAt;
  late DateTimeRange orderPeriod;
  late String size;
  late String storeName;
  late String storeAddress;
  late int price;

  CartData.fromQueryObject(
      QueryDocumentSnapshot<Map<String, dynamic>> data,
      DocumentSnapshot<Map<String, dynamic>> dreesData,
      DocumentSnapshot<Map<String, dynamic>> seller) {
    cartId = data.id;
    dressId = dreesData.id;
    name = dreesData['name'];
    imageUrl = dreesData['imageUrl'];
    addedAt = data['addedAt'];
    orderPeriod = DateTimeRange(
        start:
            DateTime.parse(data['orderPeriod'].toString().split(' - ').first),
        end: DateTime.parse(data['orderPeriod'].toString().split(' - ').last));
    size = data['size'];
    storeName = seller['storeName'];
    storeAddress = seller['storeAddress'];
    price = dreesData['price'].toInt();
  }

  CartData.fromDocObject(
      DocumentSnapshot<Map<String, dynamic>> data,
      DocumentSnapshot<Map<String, dynamic>> dreesData,
      DocumentSnapshot<Map<String, dynamic>> seller) {
    cartId = data.id;
    dressId = dreesData.id;
    name = dreesData['name'];
    imageUrl = dreesData['imageUrl'];
    addedAt = data['addedAt'];
    orderPeriod = DateTimeRange(
        start:
            DateTime.parse(data['orderPeriod'].toString().split(' - ').first),
        end: DateTime.parse(data['orderPeriod'].toString().split(' - ').last));
    size = data['size'];
    storeName = seller['storeName'];
    storeAddress = seller['storeAddress'];
    price = dreesData['price'].toInt();
  }

  Map<String, dynamic> toObject() => {
        "dressId": dressId,
        "orderPeriod": orderPeriod.toString(),
        "size": size,
        "reviewStatus": false,
      };
}
