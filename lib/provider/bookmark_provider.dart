import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/model/list_data_model.dart';

class BookmarkProvider extends ChangeNotifier {
  DatabaseService dbService;
  AuthService authService;

  BookmarkProvider({
    required this.dbService,
    required this.authService,
  }) {
    _fetchBookmarkList();
  }

  late ResultState _state;
  late List<ListDress> _bookmarkList;
  late bool _status;

  List<ListDress> get listData => _bookmarkList;
  ResultState get state => _state;
  bool get status => _status;

  _fetchBookmarkList() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final listBookmark =
          await dbService.fetchBookmarkList(authService.getUserId()!);
      if (listBookmark.isNotEmpty) {
        _bookmarkList = listBookmark;
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

  Future addBookmark(String dressId) async {
    try {
      await dbService.addBookmark(authService.getUserId()!, dressId);
      getStatus(dressId);
      _fetchBookmarkList();
    } catch (e) {
      _state = ResultState.isError;
      notifyListeners();
    }
  }

  Future removeBookmark(String dressId) async {
    try {
      await dbService.removeBookmark(authService.getUserId()!, dressId);
      getStatus(dressId);
      _fetchBookmarkList();
    } catch (e) {
      _state = ResultState.isError;
      notifyListeners();
    }
  }

  Future clearBookmark() async {
    try {
      await dbService.clearBookmark(authService.getUserId()!);
      _fetchBookmarkList();
    } catch (e) {
      _state = ResultState.isError;
      notifyListeners();
    }
  }

  Future<bool> getStatus(String dressId) async {
    final status =
        (await dbService.getBookmark(authService.getUserId()!, dressId)).exists;
    _status = status;
    notifyListeners();
    return status;
  }
}
