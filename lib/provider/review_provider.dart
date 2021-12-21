import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/cart_data.dart';
import 'package:kuaca_bali/model/order_history.dart';

class ReviewProvider extends ChangeNotifier {
  DatabaseService dbService;
  AuthService authService;
  OrderHistory orderData;

  ReviewProvider({
    required this.dbService,
    required this.authService,
    required this.orderData,
  });

  late ResultState _state;
  double _starPoint = 0;
  late List<CartData> _cartList;

  ResultState get state => _state;
  List<CartData> get cartList => _cartList;
  double get starPoint => _starPoint;

  set setStarPoint(double value) {
    _starPoint = value;
    notifyListeners();
  }

  Future<void> addReview(String msg, String userName) async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      await dbService.addReview(
          orderData.orderId, orderData.dressId, _starPoint, msg, userName);
      _state = ResultState.isSuccess;
    } catch (e) {
      _state = ResultState.isError;
    }
    notifyListeners();
  }
}
