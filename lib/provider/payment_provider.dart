import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/cart_data.dart';

class PaymentProvider extends ChangeNotifier {
  DatabaseService dbService;
  AuthService authService;
  List<String> cartId;

  PaymentProvider({
    required this.dbService,
    required this.authService,
    required this.cartId,
  }) {
    fetchPaymentData();
  }

  late ResultState _state;
  late int _totalPayment;
  late List<CartData> _cartList;
  String _paymentMethod = 'Transfer';

  int get totalPayment => _totalPayment;
  ResultState get state => _state;
  List<CartData> get cartList => _cartList;
  String get paymentMethod => _paymentMethod;

  fetchPaymentData() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      _totalPayment = 0;
      _cartList = [];
      for (var id in cartId) {
        final cartData =
            await dbService.getCartData(authService.getUserId()!, id);

        _cartList.add(cartData);
        _totalPayment +=
            (cartData.price * cartData.orderPeriod.duration.inDays);
      }
      _state = ResultState.isSuccess;
    } catch (e) {
      _state = ResultState.isError;
    }
    notifyListeners();
  }

  set setPaymentMethod(String value) {
    _paymentMethod = value;
    notifyListeners();
  }

  Future<void> addOrder() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      await dbService.addOrder(_cartList, _totalPayment, _paymentMethod);
      _state = ResultState.isSuccess;
    } catch (e) {
      _state = ResultState.isError;
    }
    notifyListeners();
  }
}
