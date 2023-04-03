import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/model/add_data_model.dart';
import 'package:kuaca_bali/model/bookmark_model.dart';
import 'package:kuaca_bali/model/cart_data.dart';
import 'package:kuaca_bali/model/detail_data_model.dart';
import 'package:kuaca_bali/model/list_data_model.dart';
import 'package:kuaca_bali/model/order_history.dart';
import 'package:kuaca_bali/model/user_data_model.dart';
import 'package:path/path.dart';

class DatabaseService {
  final _collectionDressData = FirebaseFirestore.instance.collection('dresses');
  final _collectionOrderData = FirebaseFirestore.instance.collection('orders');
  final _collectionUserData = FirebaseFirestore.instance.collection('users');

  Future<List<ListDress>> getListData() async {
    final snapshot = await _collectionDressData.get();
    List<ListDress> _dressList = [];

    for (var e in snapshot.docs) {
      final seller = await AuthService().getUserDetail(e['sellerId']);
      final data = ListDress.fromObject(e, seller!);
      _dressList.add(data);
    }

    return _dressList;
  }

  Future<List<ListDress>> getListDataQuery(String query) async {
    final filteredData = (await _collectionDressData.get()).docs.map((e) {
      if (e
          .data()['name']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase())) {
        return e;
      }
    }).toList();

    List<ListDress> _dressList = [];

    for (var e in filteredData) {
      if (e != null) {
        final seller = await AuthService().getUserDetail(e['sellerId']);
        final data = ListDress.fromObject(e, seller!);
        _dressList.add(data);
      }
    }

    return _dressList;
  }

  Future<List<ListDress>> getListDataFilter(
    List<Map<String, String>> filterData,
  ) async {
    late QuerySnapshot<Map<String, dynamic>> snapshot;

    switch (filterData.length) {
      case 1:
        if (filterData.first.keys.first.contains('semua')) {
          snapshot = await _collectionDressData.get();
        } else {
          snapshot = snapshot = await _collectionDressData
              .orderBy(filterData.first.keys.first.split(" ").first,
                  descending:
                      int.parse(filterData.first.keys.first.split(" ").last) ==
                              0
                          ? false
                          : true)
              .get();
        }
        break;
      case 2:
        snapshot = snapshot = await _collectionDressData
            .orderBy(filterData.first.keys.first.split(" ").first,
                descending:
                    int.parse(filterData.first.keys.first.split(" ").last) == 0
                        ? false
                        : true)
            .orderBy(filterData.last.keys.first.split(" ").first,
                descending:
                    int.parse(filterData.last.keys.first.split(" ").last) == 0
                        ? false
                        : true)
            .get();
        break;
      case 3:
        snapshot = snapshot = await _collectionDressData
            .orderBy('price',
                descending:
                    int.parse(filterData[0].keys.first.split(" ").last) == 0
                        ? false
                        : true)
            .orderBy('createdAt',
                descending:
                    int.parse(filterData[1].keys.first.split(" ").last) == 0
                        ? false
                        : true)
            .orderBy('name',
                descending:
                    int.parse(filterData[2].keys.first.split(" ").last) == 0
                        ? false
                        : true)
            .get();
        break;
      default:
        snapshot = await _collectionDressData.get();
    }

    List<ListDress> _dressList = [];

    for (var e in snapshot.docs) {
      final seller = await AuthService().getUserDetail(e['sellerId']);
      final data = ListDress.fromObject(e, seller!);
      _dressList.add(data);
    }

    return _dressList;
  }

  Future<DressDataElement> geDetailData(String id) async {
    final snapshotData = await _collectionDressData.doc(id).get();
    final snapshotReview =
        await _collectionDressData.doc(id).collection("reviews").get();
    final seller = await AuthService().getUserDetail(snapshotData['sellerId']);
    DressDataElement _dressDetail =
        DressDataElement.fromObject(snapshotData, seller!, snapshotReview);

    return _dressDetail;
  }

  Future<String> inputData(
    String dressName,
    int price,
    String description,
    List<String?> size,
    File imageFile,
  ) async {
    final dateNow = Timestamp.fromDate(DateTime.now());
    final sellerId = AuthService().getUserId();
    final imageUrl = await _uploadDressImage(imageFile);
    final data = AddDressData(
      dressName: dressName,
      description: description,
      imageUrl: imageUrl,
      price: price,
      listSize: size,
      sellerId: sellerId!,
      createdAt: dateNow,
      updatedAt: dateNow,
      rating: 0,
    );
    await _collectionDressData.add(data.toObject());
    return "success";
  }

  Future<String> _uploadDressImage(File _imageFile) async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/dresses/$fileName');
    final uploadTask = await firebaseStorageRef.putFile(_imageFile);
    final url = await uploadTask.ref.getDownloadURL();
    return url;
  }

  Future<List<ListDress>> fetchBookmarkList(String uId) async {
    final snapshot =
        await _collectionUserData.doc(uId).collection("bookmarks").get();
    final listBookmark =
        snapshot.docs.map((e) => Bookmark.fromObject(e)).toList();

    final List<ListDress> _snapshotDetail = [];

    for (var e in listBookmark) {
      final result = await _collectionDressData.doc(e.dressId).get();
      final seller = await AuthService().getUserDetail(result['sellerId']);
      final data = ListDress.fromObject(result, seller!);
      _snapshotDetail.add(data);
    }

    return _snapshotDetail;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBookmark(
    String uId,
    String dressID,
  ) async {
    return await _collectionUserData
        .doc(uId)
        .collection('bookmarks')
        .doc(dressID)
        .get();
  }

  Future<void> addBookmark(String uId, String dressId) async {
    await _collectionUserData
        .doc(uId)
        .collection("bookmarks")
        .doc(dressId)
        .set({"addedAt": Timestamp.now()});
  }

  Future<void> removeBookmark(String uId, String dressId) async {
    await _collectionUserData
        .doc(uId)
        .collection("bookmarks")
        .doc(dressId)
        .delete();
  }

  Future<void> clearBookmark(String uId) async {
    final snapshot =
        await _collectionUserData.doc(uId).collection("bookmarks").get();
    for (var element in snapshot.docs) {
      element.reference.delete();
    }
  }

  Future<List<CartData>> getCartList(String uId) async {
    final snapshot =
        await _collectionUserData.doc(uId).collection('carts').get();
    List<CartData> cartList = [];
    for (var e in snapshot.docs) {
      final dreesData = await _collectionDressData.doc(e.id).get();
      final seller =
          await _collectionUserData.doc(dreesData.data()!['sellerId']).get();
      cartList.add(CartData.fromQueryObject(e, dreesData, seller));
    }

    return cartList;
  }

  Future<CartData> getCartData(String uId, String cartId) async {
    final snapshot = await _collectionUserData
        .doc(uId)
        .collection('carts')
        .doc(cartId)
        .get();

    final dreesData = await _collectionDressData.doc(snapshot.id).get();
    final seller =
        await _collectionUserData.doc(dreesData.data()!['sellerId']).get();
    final cartData = CartData.fromDocObject(snapshot, dreesData, seller);

    return cartData;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> addCart(
    String uId,
    String dressId,
    String date,
    String size,
  ) async {
    await _collectionUserData.doc(uId).collection("carts").doc(dressId).set(
      {"size": size, "orderPeriod": date, "addedAt": Timestamp.now()},
    );
    return await _collectionUserData
        .doc(uId)
        .collection("carts")
        .doc(dressId)
        .get();
  }

  Future<void> removeCart(String uId, String cartId) async {
    await _collectionUserData.doc(uId).collection("carts").doc(cartId).delete();
  }

  Future<void> clearCart(String uId) async {
    final snapshot =
        await _collectionUserData.doc(uId).collection("carts").get();
    for (var element in snapshot.docs) {
      element.reference.delete();
    }
  }

  Future<void> addOrder(
    List<CartData> cartList,
    int totalPayment,
    String paymentMethod,
  ) async {
    final customerId = AuthService().getUserId();
    final orderData = await _collectionOrderData.add(
      {
        "customerId": customerId,
        "orderedAt": Timestamp.now(),
        "paymentMethod": paymentMethod,
        "totalPayment": totalPayment,
        "status": 0
      },
    );

    for (var cart in cartList) {
      await orderData
          .collection('oderedItems')
          .doc(cart.cartId)
          .set(cart.toObject());
    }

    await _collectionUserData
        .doc(customerId)
        .collection('historyOrders')
        .doc(orderData.id)
        .set({"addedAt": Timestamp.now(), "reviewStatus": false});

    for (var cart in cartList) {
      await _collectionUserData
          .doc(customerId)
          .collection('carts')
          .doc(cart.cartId)
          .delete();
    }
  }

  Future<List<OrderHistory>> fetchOrderList(String uId) async {
    final listOrder =
        await _collectionUserData.doc(uId).collection('historyOrders').get();

    final List<OrderHistory> listOrderItems;

    listOrderItems = [];
    for (var e in listOrder.docs) {
      final snapOrder = await _collectionOrderData.doc(e.id).get();
      final snapOrderedItems =
          await _collectionOrderData.doc(e.id).collection('oderedItems').get();
      print(snapOrder["status"]);
      // if (snapOrder["status"] == 1) {
      for (var items in snapOrderedItems.docs) {
        final snapDressData =
            await _collectionDressData.doc(items['dressId']).get();
        final snapSellerData =
            await _collectionUserData.doc(snapDressData['sellerId']).get();
        listOrderItems.add(
          OrderHistory.fromObject(
            snapOrder,
            items,
            ListDress.fromObject(
              snapDressData,
              UserData.fromObject(snapSellerData),
            ),
          ),
        );
      }
      // }
    }
    return listOrderItems;
  }

  Future<DocumentReference<Map<String, dynamic>>> addReview(
    String orderId,
    String dressId,
    double starPoint,
    String msg,
    String userName,
  ) async {
    final result =
        await _collectionDressData.doc(dressId).collection('reviews').add({
      "orderId": orderId,
      "starPoint": starPoint,
      "msg": msg,
      "userName": userName,
    });

    await _collectionOrderData
        .doc(orderId)
        .collection('oderedItems')
        .doc(dressId)
        .update({"reviewStatus": true});
    return result;
  }
}
