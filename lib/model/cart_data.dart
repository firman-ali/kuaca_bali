import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartData {
  late String dressId;
  late String name;
  late String imageUrl;
  late Timestamp addedAt;
  late DateTimeRange orderPeriod;
  late int size;
  late String storeName;
  late int price;

  CartData.fromObject(
      QueryDocumentSnapshot<Map<String, dynamic>> data,
      DocumentSnapshot<Map<String, dynamic>> dreesData,
      DocumentSnapshot<Map<String, dynamic>> seller) {
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
    price = dreesData['price'];
  }
}
