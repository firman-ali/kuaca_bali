import 'package:flutter/cupertino.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/list_data_model.dart';

class HomeProvider extends ChangeNotifier {
  DatabaseService dbService;
  HomeProvider({required this.dbService}) {
    _fetchAllData();
  }

  final List<Map<String, String>> _filterItem = [
    {'price 0': 'Termurah'},
    {'price 1': 'Termahal'},
    {'createdAt 1': 'Terbaru'},
    {'createdAt 0': 'Terlama'},
    {'name 0': 'Urutan A-Z'},
    {'name 1': 'Urutan Z-A'},
  ];

  List<ListDress> _listData = [];
  late ResultState _state;
  List<Map<String, String>> _filterSelected = [];

  ResultState get state => _state;
  List<ListDress> get listData => _listData;
  List<Map<String, String>> get filterSelected => _filterSelected;
  List<Map<String, String>> get filterItem => _filterItem;

  Future<void> _fetchAllData() async {
    if (_filterSelected.isEmpty) {
      _filterSelected.add({'semua': 'Semua'});
    }
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

  Future<void> fetchDataSorting() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final List<ListDress> snapshot;

      snapshot = await dbService.getListDataFilter(_filterSelected);

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

  set addItemFilter(List<Map<String, String>> values) {
    _filterSelected = values;

    if (_filterSelected.map((e) => e.containsKey('semua')).contains(true) &&
        values.isNotEmpty) {
      _filterSelected.removeAt(0);
      _filterSelected.join(', ');
    } else if (values.isEmpty) {
      _filterSelected.add({'semua': 'Semua'});
    }
    fetchDataSorting();
  }

  Future refreshData() async {
    await _fetchAllData();
  }
}
