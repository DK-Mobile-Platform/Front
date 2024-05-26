//homePage에서 사용, 요약 생성하기 버튼을 눌렀을 때
//end-point : AI_process
//post 값 : user_id
//response 값 : summary_text, image

import 'dart:convert';
import 'package:http/http.dart' as http;

class AIProcessDataSource {
  final String baseUrl = "http://localhost:8000"; //실제 주소로 바꿔야함

  Future<Map<String, dynamic>> postUserId(String userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/AI_process'),
      body: {'user_id': userId},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch summary data');
    }
  }
}
