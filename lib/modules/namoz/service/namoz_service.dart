import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:qiblah_pro/modules/namoz/model/namoz_model.dart';

class NamozService {
  Future<List<NamozModel>> getNamozData() async {
    final rawData = await rootBundle.loadString('assets/jsons/namoz.json');
    final jsonList = jsonDecode(rawData);

    List<NamozModel> list = <NamozModel>[];
    for (final json in jsonList) {
      list.add(NamozModel.fromJson(json));
    }
    return list;
  }
}
