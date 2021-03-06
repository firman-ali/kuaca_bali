import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/model/user_data_model.dart';

class ChatService {
  final _collectionUser = FirebaseFirestore.instance.collection('users');
  final _collectionChat = FirebaseFirestore.instance.collection('chats');

  Stream<QuerySnapshot<Map<String, dynamic>>> getListChatStream(String uId) {
    return _collectionUser.doc(uId).collection("chats").snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> friendDataStream(String uId) {
    return _collectionUser.doc(uId).snapshots();
  }

  Future<UserData> getFriendData(String uId) async {
    final snapshotData = await _collectionUser.doc(uId).get();
    return UserData.fromObject(snapshotData);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchChatDataStream(
      String roomId) {
    return _collectionChat
        .doc(roomId)
        .collection("messages")
        .orderBy("cretaedAt", descending: false)
        .snapshots();
  }

  Future<void> addMessage(String msg, String roomId, String friendId) async {
    await _collectionChat.doc(roomId).collection("messages").add({
      "msg": msg,
      "cretaedAt": Timestamp.now(),
      "fromId": AuthService().getUserId()
    });
    final unRead = (await _collectionUser
            .doc(friendId)
            .collection("chats")
            .doc(roomId)
            .get())
        .data()?["unRead"] as int?;

    await _collectionUser.doc(friendId).collection("chats").doc(roomId).set({
      "friendId": AuthService().getUserId(),
      "unRead": (unRead ?? 0) + 1,
      "updatedAt": Timestamp.now()
    });
  }

  Future<String> createRoomChat(String userId, String friendId) async {
    final chatRoom = await _collectionChat.add({
      "users": [userId, friendId],
      "createdAt": Timestamp.now()
    });

    await _collectionUser
        .doc(userId)
        .collection("chats")
        .doc(chatRoom.id)
        .set({"friendId": friendId, "unRead": 0, "updatedAt": Timestamp.now()});

    return chatRoom.id;
  }

  Future<void> readMsg(String uId, String roomId, friendId) async {
    await _collectionUser
        .doc(uId)
        .collection('chats')
        .doc(roomId)
        .set({"friendId": friendId, "unRead": 0, "updatedAt": Timestamp.now()});
  }

  Future<String?> getRoomFromUser(String friendId, String uId) async {
    QuerySnapshot<Map<String, dynamic>>? snapshot;
    snapshot = await _collectionChat
        .where('users', isEqualTo: [friendId, uId])
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) {
      snapshot = await _collectionChat
          .where('users', isEqualTo: [uId, friendId])
          .limit(1)
          .get();
    }
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    }
    return null;
  }

  Future<void> clearChatRoom() async {
    final snapshot = await _collectionUser
        .doc(AuthService().getUserId())
        .collection('chats')
        .get();
    for (var element in snapshot.docs) {
      element.reference.delete();
    }
  }
}
