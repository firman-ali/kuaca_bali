import 'package:cloud_firestore/cloud_firestore.dart';

class ListRoomChat {
  late String msg;
  late Timestamp cretaedAt;
  late String fromId;

  ListRoomChat({
    required this.msg,
    required this.cretaedAt,
    required this.fromId,
  });

  ListRoomChat.fromObject(
    QueryDocumentSnapshot<Map<String, dynamic>> data,
  ) {
    msg = data['msg'];
    cretaedAt = data['cretaedAt'];
    fromId = data['fromId'];
  }
}
