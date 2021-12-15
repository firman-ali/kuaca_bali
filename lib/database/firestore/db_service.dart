import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/model/add_data_model.dart';
import 'package:kuaca_bali/model/detail_data_model.dart';
import 'package:kuaca_bali/model/list_data_model.dart';
import 'package:path/path.dart';

class DatabaseService {
  final _collectionData = FirebaseFirestore.instance.collection('dresses');
  final _collectionUserData = FirebaseFirestore.instance.collection('users');

  Future<List<ListDress>> getListData() async {
    final snapshot = await _collectionData.get();
    List<ListDress> _dressList = [];

    for (var e in snapshot.docs) {
      final seller = await AuthService().getUserDetail(e['sellerId']);
      final data = ListDress.fromObject(e, seller!);
      _dressList.add(data);
    }

    return _dressList;
  }

  Future<List<ListDress>> getListDataQuery(String query) async {
    final snapshotName = await _collectionData
        .where('name', isGreaterThanOrEqualTo: query)
        .get();
    List<ListDress> _dressList = [];

    for (var e in snapshotName.docs) {
      final seller = await AuthService().getUserDetail(e['sellerId']);
      final data = ListDress.fromObject(e, seller!);
      _dressList.add(data);
    }

    return _dressList;
  }

  Future<List<ListDress>> getListDataFilter(String sort, bool desc) async {
    final snapshotName =
        await _collectionData.orderBy(sort, descending: desc).get();
    List<ListDress> _dressList = [];

    for (var e in snapshotName.docs) {
      final seller = await AuthService().getUserDetail(e['sellerId']);
      final data = ListDress.fromObject(e, seller!);
      _dressList.add(data);
    }

    return _dressList;
  }

  Future<DressDataElement> geDetailData(String id) async {
    final snapshotData = await _collectionData.doc(id).get();
    final snapshotReview =
        await _collectionData.doc(id).collection("reviews").get();
    final seller = await AuthService().getUserDetail(snapshotData['sellerId']);
    DressDataElement _dressDetail =
        DressDataElement.fromObject(snapshotData, seller!, snapshotReview);

    return _dressDetail;
  }

  Future<String> inputData(String dressName, int price, String description,
      String size, File imageFile) async {
    final dateNow = Timestamp.fromDate(DateTime.now());
    final sellerId = AuthService().getUserId();
    final imageUrl = await _uploadDressImage(imageFile);
    final data = AddDressData(
      dressName: dressName,
      description: description,
      imageUrl: imageUrl,
      price: price,
      size: size,
      sellerId: sellerId!,
      createdAt: dateNow,
      updatedAt: dateNow,
    );
    await _collectionData.add(data.toObject());
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

  Future<QuerySnapshot<Map<String, dynamic>>> fetchBookmarkList(
      String uId) async {
    return await _collectionUserData.doc(uId).collection("bookmarks").get();
  }

  Future<void> addBookmark(String uId, String dressId) async {
    await _collectionUserData
        .doc(uId)
        .collection("bookmarks")
        .add({"dressId": dressId, "addedAt": Timestamp.now()});
  }

  Future<void> removeBookmark(String uId, String bookId) async {
    await _collectionUserData
        .doc(uId)
        .collection("bookmarks")
        .doc(bookId)
        .delete();
  }

  Future<void> clearBookmark(String uId) async {
    final bookmark = await _collectionUserData
        .doc(uId)
        .collection("bookmarks")
        .firestore
        .clearPersistence();
  }

  Future<void> addCart(String uId, String dressId) async {
    await _collectionUserData
        .doc(uId)
        .collection("carts")
        .add({"dressId": dressId, "addedAt": Timestamp.now()});
  }

  Future<void> removeCart(String uId, String cartId) async {
    await _collectionUserData.doc(uId).collection("carts").doc(cartId).delete();
  }

  Future<void> clearCart(String uId) async {
    final carts = await _collectionUserData.doc(uId).collection("carts").get();
    carts.docs.clear();
  }
}
