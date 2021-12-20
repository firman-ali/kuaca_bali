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
    _fetchCartList();
  }

  int _dressSize = 0;
  late ResultState _state;
  late UserData _user;
  late List<CartData> _cartList;

  UserData get user => _user;
  ResultState get state => _state;
  int get size => _dressSize;
  List<CartData> get cartList => _cartList;

  _fetchCartList() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final listBookmark =
          await dbService.getCartList(authService.getUserId()!);
      if (listBookmark.isNotEmpty) {
        _cartList = listBookmark;
        _state = ResultState.hasData;
        notifyListeners();
      } else {
        _state = ResultState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.isError;
      notifyListeners();
    }
  }

  set addSize(int size) {
    _dressSize = size;
    notifyListeners();
  }

  Future addOrder(String date, String dressId, String uId) async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      await dbService.addCart(uId, dressId, date, _dressSize);
      _state = ResultState.isSuccess;
      notifyListeners();
    } catch (e) {
      _state = ResultState.isError;
      notifyListeners();
    }
  }
}
