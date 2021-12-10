import 'package:flutter/cupertino.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/detail_data_model.dart';
import 'package:kuaca_bali/model/user_data_model.dart';

class DetailDataProvider extends ChangeNotifier {
  DatabaseService dbService;
  String dressId;
  DetailDataProvider({
    required this.dbService,
    required this.dressId,
  }) {
    _fetchData();
  }

  late DressDataElement _dressData;
  late ResultState _state;
  late UserData _user;

  UserData get user => _user;
  ResultState get state => _state;
  DressDataElement get data => _dressData;

  _fetchData() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final snapshot = await dbService.geDetailData(dressId);
      _dressData = snapshot;
      _state = ResultState.hasData;
    } catch (e) {
      _state = ResultState.isError;
    }
    notifyListeners();
  }
}
