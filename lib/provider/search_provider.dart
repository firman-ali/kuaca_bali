import 'package:flutter/material.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/list_data_model.dart';

class SearchProvider extends ChangeNotifier {
  DatabaseService dbService;
  SearchProvider({required this.dbService}) {
    _state = ResultState.isWaiting;
  }

  List<ListDress> _listData = [];
  late ResultState _state;

  ResultState get state => _state;
  List<ListDress> get listData => _listData;

  searchData(String query) async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final snapshot = await dbService.getListDataQuery(query);
      if (snapshot.isNotEmpty) {
        _listData = snapshot;
        _state = ResultState.hasData;
      } else {
        _state = ResultState.noData;
      }
    } catch (e) {
      _state = ResultState.isError;
      print(e.toString());
    }
    notifyListeners();
  }
}
