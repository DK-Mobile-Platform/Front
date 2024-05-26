//파일 첨부 동작 처리
// fileAttach_dataSource <-> homePage

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../dataSource/fileAttach_dataSource.dart';
import '../model/attachedFile.dart';
import '../model/user.dart';

class FileAttachViewModel extends ChangeNotifier {
  final FileAttachDataSource dataSource;
  final User user;

  String? filePath = null; // 초기값을 null로 설정
  bool loading = false;

  FileAttachViewModel(this.dataSource, this.user);

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {

      filePath = result.files.single.name;

      if (filePath != null) {
        print(filePath);
        notifyListeners(); // 상태 변경을 알림
      } else {
        print('파일 경로가 null입니다.');
      }
    } else {
      print('파일이 선택되지 않았습니다.');
    }
  }

  Future<void> uploadFile() async {
    loading = true;
    notifyListeners();

    if (filePath != null) {
      AttachedFile attachedFile = AttachedFile(filePath: filePath!);
      await dataSource.uploadFile(user, attachedFile);
    } else {
      print('No file selected or user ID is empty');
    }

    loading = false;
    notifyListeners();
  }
}
