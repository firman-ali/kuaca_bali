import 'package:flutter/cupertino.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/user_data_model.dart';

class AuthProvider extends ChangeNotifier {
  AuthService service;
  AuthProvider({required this.service}) {
    _checkAuthentication();
  }

  late bool _isSignIn;
  late ResultState _state;
  late UserData _user;
  late String? _userName;

  UserData get user => _user;
  bool get isSignIn => _isSignIn;
  ResultState get state => _state;
  String? get name => _userName;

  _checkAuthentication() async {
    _state = ResultState.isLoading;
    notifyListeners();
    final user = service.getUserId();
    if (user == null) {
      _isSignIn = false;
    } else {
      await _getUser();
      _isSignIn = true;
    }
    _state = ResultState.finished;
    notifyListeners();
  }

  signOut() async {
    await service.userSignOut();
    _isSignIn = !_isSignIn;
    notifyListeners();
  }

  Future<void> signIn(String email, String pass) async {
    final result = await service.signIn(email, pass);
    if (result != null) {
      _isSignIn = true;
    } else {
      _isSignIn = false;
    }
    await _getUser();
    notifyListeners();
  }

  Future<void> signUp(String email, String pass, String name,
      String phoneNumber, String address) async {
    final result =
        await service.signUp(email, pass, name, phoneNumber, address);
    if (result != null) {
      _isSignIn = true;
    } else {
      _isSignIn = false;
    }
    await _getUser();
    notifyListeners();
  }

  Future<void> _getUser() async {
    final user = await service.getUserDetail(service.getUserId()!);
    _user = user!;
    final dataName = user.name.split(" ").map((e) => e).toList();
    if (dataName.elementAt(0).length > 2) {
      _userName = dataName.elementAt(0);
    } else {
      _userName = dataName.elementAt(1);
    }
  }
}
