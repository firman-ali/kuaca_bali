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
  late String _sortData;

  UserData get user => _user;
  ResultState get state => _state;
  List<ListDress> get listData => _listData;
  String get sort => _sortData;

  _fetchAllData() async {
    _sortData = 'Semua';
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
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> fetchDataSorting(String sort) async {
    _sortData = sort;
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final List<ListDress> snapshot;
      switch (sort) {
        case 'Produk Terbaru':
          snapshot = await dbService.getListDataFilter('createdAt', true);
          break;
        case 'Produk Terlama':
          snapshot = await dbService.getListDataFilter('createdAt', false);
          break;
        case 'Harga Termurah':
          snapshot = await dbService.getListDataFilter('price', false);
          break;
        case 'Harga Termahal':
          snapshot = await dbService.getListDataFilter('price', true);
          break;
        case 'Nama A-Z':
          snapshot = await dbService.getListDataFilter('name', false);
          break;
        case 'Nama Z-A':
          snapshot = await dbService.getListDataFilter('name', true);
          break;
        default:
          snapshot = await dbService.getListData();
      }

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
