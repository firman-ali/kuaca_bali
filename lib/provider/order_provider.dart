import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/user_data_model.dart';

final size = ["Small", "Medium", "Large", "Extra Large"];
final avatar = ["S", "M", "L", "XL"];

class OrderProvider extends ChangeNotifier {
  DatabaseService dbService;
  String dressId;
  OrderProvider({
    required this.dbService,
    required this.dressId,
  });

  int _dressSize = 0;
  late ResultState _state;
  late UserData _user;

  UserData get user => _user;
  ResultState get state => _state;
  int get size => _dressSize;

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
