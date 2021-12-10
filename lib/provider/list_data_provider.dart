import 'package:flutter/cupertino.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/list_data_model.dart';
import 'package:kuaca_bali/model/user_data_model.dart';

class ListDataProvider extends ChangeNotifier {
  DatabaseService dbService;
  ListDataProvider({required this.dbService}) {
    _fetchAllData();
  }

  List<ListDress> _listData = [];
  late ResultState _state;
  late UserData _user;

  UserData get user => _user;
  ResultState get state => _state;
  List<ListDress> get listData => _listData;

  _fetchAllData() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final snapshot = await dbService.getListData();
      if (snapshot.isNotEmpty) {
        _listData = snapshot;
        _state = ResultState.hasData;
      } else {
        _state = ResultState.noData;
      }
    } catch (e) {
      _state = ResultState.isError;
    }
    notifyListeners();
  }
}
