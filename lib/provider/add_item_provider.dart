import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';

List<String> size = ['Small', 'Medium', 'Large', 'Xtra Large'];

class AddItemProvider extends ChangeNotifier {
  DatabaseService dbService;
  AuthService authService;

  AddItemProvider({
    required this.dbService,
    required this.authService,
  });

  late String _size;
  List<String?> _listSize = [];
  XFile? _image;
  late Uint8List _imageUin;

  XFile? get image => _image;
  List<String?> get listSize => _listSize;
  String get size => _size;
  Uint8List get imageUin => _imageUin;

  addItem(String dressName, int price, String description) {
    dbService.inputData(
      dressName,
      price,
      description,
      _listSize,
      File(_image!.path),
    );
  }

  set setListSize(List<String?> listSize) {
    _listSize = listSize;
    notifyListeners();
  }

  set setImage(XFile? image) {
    _image = image;
    notifyListeners();
  }

  set setImageUin(Uint8List imageValue) {
    _imageUin = imageValue;
    notifyListeners();
  }
}
