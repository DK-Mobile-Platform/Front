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

  String? filePath;
  bool loading = false;

  FileAttachViewModel(this.dataSource, this.user);

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      filePath = result.files.single.path;
      notifyListeners();
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
