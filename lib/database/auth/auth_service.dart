import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kuaca_bali/model/user_data_model.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> signUp(String email, String password, String name,
      String phoneNumber, String address) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _inputUserData(
          userCredential.user!.uid, name, email, phoneNumber, address);
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> userSignOut() async {
    await firebaseAuth.signOut();
    return 'User Log Out';
  }

  String getUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  Future<UserData?> getUserDetail(String uid) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return UserData.fromObject(snapshot);
    } else {
      return null;
    }
  }

  Future<void> _inputUserData(String uId, String name, String email,
      String phoneNumber, String address) async {
    final createdAt = Timestamp.fromDate(DateTime.now());
    final updatedAt = Timestamp.fromDate(DateTime.now());
    final user = UserData(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
      createdAt: createdAt,
      updatedAt: updatedAt,
      role: 'user',
    );
    final firebase = FirebaseFirestore.instance.collection('users').doc(uId);
    await firebase.set(user.toObject());
  }

  Future<String> updateUserData(String uId, String name, String phoneNumber,
      String address, File imageFile) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/users/$uId');
    final dateNow = Timestamp.fromDate(DateTime.now());
    final uploadTask = await firebaseStorageRef.putFile(imageFile);
    final imageUrl = await uploadTask.ref.getDownloadURL();

    final Map<String, dynamic> userData = {
      "name": name,
      "phoneNumber": phoneNumber,
      "address": address,
      "updatedAt": dateNow,
      "imageUrl": imageUrl,
    };

    final firebase = FirebaseFirestore.instance.collection('users').doc(uId);
    await firebase.update(userData);
    return "success";
  }

  Future<void> sellerRegister(String storeName, String storeAddress) async {
    final registerAt = Timestamp.fromDate(DateTime.now());

    final uid = getUserId();
    final firebase = FirebaseFirestore.instance.collection('users').doc(uid);
    final Map<String, dynamic> registerUser = {
      "sellerRegisterAt": registerAt,
      "storeName": storeName,
      "storeAddress": storeAddress,
      "role": "seller",
    };

    await firebase.update(registerUser);
  }
}
