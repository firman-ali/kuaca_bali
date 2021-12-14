import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final _collectionUser = FirebaseFirestore.instance.collection('users');
  final _collectionChat = FirebaseFirestore.instance.collection('chats');

  Stream<QuerySnapshot<Map<String, dynamic>>> getListChat(String uId) {
    return _collectionUser.doc(uId).collection("chats").snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> friendData(String uId) {
    return _collectionUser.doc(uId).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchChatData(String roomId) {
    return _collectionChat
        .doc(roomId)
        .collection("messages")
        .orderBy("cretaedAt", descending: true)
        .snapshots();
  }

  Future<void> addMessage(
      String msg, String roomId, String uId, String friendId) async {
    await _collectionChat
        .doc(roomId)
        .collection("messages")
        .add({"msg": msg, "cretaedAt": Timestamp.now()});
    final unRead = (await _collectionUser
            .doc(friendId)
            .collection("chats")
            .doc(roomId)
            .get())
        .data()?["unRead"] as int?;

    await _collectionUser.doc(friendId).collection("chats").doc(roomId).set({
      "friendId": uId,
      "unRead": (unRead ?? 0) + 1,
      "updatedAt": Timestamp.now()
    });
  }

  Future<void> createRoomChat(String userId, String friendId) async {
    final chatRoom = await _collectionChat.add({
      "users": [userId, friendId],
      "createdAt": Timestamp.now()
    });

    await _collectionUser
        .doc(userId)
        .collection("chats")
        .doc(chatRoom.id)
        .set({"friendId": friendId, "unRead": 0, "updatedAt": Timestamp.now()});
  }

  Future<void> readMsg(String uId, String roomId) async {
    await _collectionUser
        .doc(uId)
        .collection('chats')
        .doc(roomId)
        .set({"unRead": 0});
  }
}
