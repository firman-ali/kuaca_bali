import 'package:cloud_firestore/cloud_firestore.dart';

class Bookmark {
  late String dressId;
  late Timestamp addedAt;

  Bookmark.fromObject(DocumentSnapshot<Map<String, dynamic>> data) {
    dressId = data.id;
    addedAt = data['addedAt'];
  }
}
