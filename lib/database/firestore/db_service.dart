import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuaca_bali/model/detail_data.dart';
import 'package:kuaca_bali/model/list_data.dart';

class DatabaseService {
  final _collection = FirebaseFirestore.instance.collection('dress');

  Future<List<DressData>> getListData() async {
    final snapshot = await _collection.get();
    List<DressData> _dressList = [];

    _dressList = snapshot.docs.map((e) => DressData.fromObject(e)).toList();

    return _dressList;
  }

  Future<DressDataElement> geDataById(String id) async {
    final snapshot = await _collection.doc(id).get();
    DressDataElement _dressDetail = DressDataElement.fromObject(snapshot);

    return _dressDetail;
  }
}
