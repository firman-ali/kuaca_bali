import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuaca_bali/model/user_data.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> signUp(String email, String password, String name,
      String phoneNumber, String address) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
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

      await _addUser(userCredential.user!.uid, user);
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

  Future<void> _addUser(String uid, UserData user) async {
    final firebase = FirebaseFirestore.instance.collection('users').doc(uid);
    final newUser = user.toJson();
    await firebase.set(newUser);
  }
}
