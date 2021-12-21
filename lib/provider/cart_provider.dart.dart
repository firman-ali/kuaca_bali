import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/cart_data.dart';
import 'package:kuaca_bali/model/user_data_model.dart';

final size = ["Small", "Medium", "Large", "Extra Large"];
final avatar = ["S", "M", "L", "XL"];

class CartProvider extends ChangeNotifier {
  DatabaseService dbService;
  AuthService authService;

  CartProvider({
    required this.dbService,
    required this.authService,
  }) {
    fetchCartList();
  }

  int _dressSize = 0;
  late ResultState _state;
  late UserData _user;
  late List<CartData> _cartList;
  late String _cartId;

  UserData get user => _user;
  ResultState get state => _state;
  int get size => _dressSize;
  List<CartData> get cartList => _cartList;
  String get cartId => _cartId;

  fetchCartList() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final listCart = await dbService.getCartList(authService.getUserId()!);
      if (listCart.isNotEmpty) {
        _cartList = listCart;
        _state = ResultState.hasData;
      } else {
        _cartList = [];
        _state = ResultState.noData;
      }
    } catch (e) {
      _state = ResultState.isError;
    }
    notifyListeners();
  }

  set addSize(int size) {
    _dressSize = size;
    notifyListeners();
  }

  Future<String?> addCart(String date, String dressId, String uId) async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final result = await dbService.addCart(uId, dressId, date, _dressSize);
      _state = ResultState.isSuccess;
      notifyListeners();
      return result.id;
    } catch (e) {
      _state = ResultState.isError;
      notifyListeners();
      return null;
    }
  }

  Future<void> removeCart(String cartId) async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      await dbService.removeCart(authService.getUserId()!, cartId);
      _state = ResultState.isSuccess;
      notifyListeners();
    } catch (e) {
      _state = ResultState.isError;
      notifyListeners();
    }
  }

  Future clearCartList(String uId) async {
    await dbService.clearCart(uId);

    fetchCartList();
  }
}
