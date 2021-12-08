import 'package:flutter/cupertino.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';

class AuthProvider extends ChangeNotifier {
  AuthService service;
  AuthProvider({required this.service}) {
    _checkAuthentication();
  }

  late bool _isSignIn;
  late ResultState _state;

  bool get isSignIn => _isSignIn;
  ResultState get state => _state;

  _checkAuthentication() async {
    _state = ResultState.isLoading;
    notifyListeners();
    final user = service.getUserId();
    if (user == null) {
      _isSignIn = false;
    } else {
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

  Future<String> signIn(String email, String pass) async {
    _state = ResultState.isLoading;
    notifyListeners();
    final result = await service.signIn(email, pass);
    if (result != null) {
      _isSignIn = true;
      _state = ResultState.finished;
      notifyListeners();
      return "success";
    } else {
      _state = ResultState.finished;
      return "error";
    }
  }

  Future<String> signUp(String email, String pass, String name,
      String phoneNumber, String address) async {
    _state = ResultState.isLoading;
    notifyListeners();
    final result =
        await service.signUp(email, pass, name, phoneNumber, address);
    if (result != null) {
      _isSignIn = true;
      _state = ResultState.finished;
      notifyListeners();
      return "success";
    } else {
      _state = ResultState.finished;
      return "error";
    }
  }
}