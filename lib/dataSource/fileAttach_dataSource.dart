//homePage에서 사용, 파일 붙이기 및 전처리
//end-point : Audio_preprocess
//post 값 : file, user_id

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../model/attachedFile.dart';
import '../model/user.dart';


class FileAttachDataSource {
  final String baseUrl = "http://220.149.250.118:8000"; //실제 주소로 바꿔야 함

  Future<void> uploadFile(User user, AttachedFile attachedFile) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/Audio_preprocess'))
      ..fields['user_id'] = user.userId!
      ..files.add(
        await http.MultipartFile.fromPath(
          'file',
          attachedFile.filePath,
          contentType: MediaType.parse(lookupMimeType(attachedFile.filePath) ?? 'application/octet-stream'),
        ),
      );

    var response = await request.send();
    if (response.statusCode == 200) {
      print('파일 업로드 성공');
    } else {
      print('파일 업로드 실패');
    }
  }
}
