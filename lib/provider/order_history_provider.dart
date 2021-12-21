import 'package:flutter/material.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/order_history.dart';

class OrderHistoryProvider extends ChangeNotifier {
  DatabaseService dbService;
  AuthService authService;

  OrderHistoryProvider({
    required this.dbService,
    required this.authService,
  }) {
    _fetchHistoryData();
  }

  late List<OrderHistory> _orderList;
  late ResultState _state;

  ResultState get state => _state;
  List<OrderHistory> get orderList => _orderList;

  _fetchHistoryData() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final snapshot = await dbService.fetchOrderList(authService.getUserId()!);
      if (snapshot.isNotEmpty) {
        _orderList = snapshot;
        _state = ResultState.hasData;
      } else {
        _state = ResultState.noData;
      }
    } catch (e) {
      _state = ResultState.isError;
    }
    notifyListeners();
  }

  refreshData() {
    _fetchHistoryData();
  }
}
