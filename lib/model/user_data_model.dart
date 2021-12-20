import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  UserData({
    this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    this.imageUrl,
    this.storeName,
    this.storeAddress,
    this.sellerRegisterAt,
  });

  final String? id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final String role;
  final String? imageUrl;
  final String? storeName;
  final String? storeAddress;
  final Timestamp? sellerRegisterAt;

  factory UserData.fromObject(DocumentSnapshot<Map<String, dynamic>> data) =>
      UserData(
        id: data.id,
        name: data["name"],
        email: data["email"],
        phoneNumber: data["phoneNumber"],
        address: data["address"],
        createdAt: data["createdAt"],
        updatedAt: data["updatedAt"],
        role: data["role"],
        imageUrl: data["imageUrl"],
        storeName: data["storeName"],
        storeAddress: data["storeAddress"],
        sellerRegisterAt: data["sellerRegisterAt"],
      );

  Map<String, dynamic> toObject() => {
        "id": id,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "role": role,
        "imageUrl": imageUrl,
        "storeName": storeName,
        "storeAddress": storeAddress,
        "sellerRegisterAt": sellerRegisterAt,
      };
}
