//요약 생성 동작 처리
// aiProcess_dataSource <-> homePage

import 'package:flutter/material.dart';
import '../dataSource/aiProcess_dataSource.dart';
import '../model/aiSummary.dart';

class AIProcessViewModel extends ChangeNotifier {
  final AIProcessDataSource dataSource;

  AIProcessViewModel(this.dataSource);

  bool loading = false;
  bool dataReceived = false;
  AISummary? aiSummary;

  Future<void> postUserId(String userId) async {
    loading = true;
    dataReceived = false;
    notifyListeners();

    try {
      final responseData = await dataSource.postUserId(userId);
      aiSummary = AISummary.fromJson(responseData);
      dataReceived = true;
    } catch (error) {
      print('$error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
