import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/model/add_data_model.dart';
import 'package:kuaca_bali/model/detail_data_model.dart';
import 'package:kuaca_bali/model/list_data_model.dart';
import 'package:path/path.dart';

class DatabaseService {
  final _collection = FirebaseFirestore.instance.collection('dresses');

  Future<List<ListDress>> getListData() async {
    final snapshot = await _collection.get();
    List<ListDress> _dressList = [];

    for (var e in snapshot.docs) {
      final seller = await AuthService().getUserDetail(e['sellerId']);
      final data = ListDress.fromObject(e, seller!);
      _dressList.add(data);
    }

    return _dressList;
  }

  Future<List<ListDress>> getListDataQuery(String query) async {
    final snapshotName =
        await _collection.where('name', isGreaterThanOrEqualTo: query).get();
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
        await _collection.orderBy(sort, descending: desc).get();
    List<ListDress> _dressList = [];

    for (var e in snapshotName.docs) {
      final seller = await AuthService().getUserDetail(e['sellerId']);
      final data = ListDress.fromObject(e, seller!);
      _dressList.add(data);
    }

    return _dressList;
  }

  Future<DressDataElement> geDetailData(String id) async {
    final snapshot = await _collection.doc(id).get();
    final seller = await AuthService().getUserDetail(snapshot['sellerId']);
    DressDataElement _dressDetail =
        DressDataElement.fromObject(snapshot, seller!);

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
    await _collection.add(data.toObject());
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
}
