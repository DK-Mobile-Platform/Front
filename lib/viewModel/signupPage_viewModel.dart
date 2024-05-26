import 'package:flutter/material.dart';
import 'package:mobileplatform_project/dbHelper/user_dbHelper.dart';
import 'package:mobileplatform_project/model/user.dart';
import 'package:http/http.dart' as http;
import '../view/front/loginPage.dart';
import 'dart:convert';

class SignUpViewModel extends ChangeNotifier {
  late User user;
  late BuildContext context;

  SignUpViewModel(this.context) {
    user = User(id: '', username: '', password: '', country: '',userId: '');
  }



  void signUp() async {
    try {
      if (user.username.isNotEmpty &&
          user.password.isNotEmpty &&
          user.id.isNotEmpty &&
          user.country.isNotEmpty) {
        await DBHelper.insertUser(user);
        // api User_initial call
        final String baseUrl = "http://220.149.250.118:8000"; //실제 주소로 바꿔야함
        Future<Map<String, dynamic>> postUserId(String userId) async {
          print("User_inital api call  $userId");

            final response = await http.post(
              Uri.parse('$baseUrl/User_initial/?user_id=$userId'), // 쿼리 문자열 대신 URL에 직접 추가
            );
            print(response);
            if (response.statusCode == 200) {
              // If the request was successful, return some data
              return {'status': 'success', 'message': 'User initialized successfully'};
            } else {
              // If the request failed, return an error message
              return {'status': 'error', 'message': 'Failed to initialize user: ${response.statusCode}'};

          }
        }


        await postUserId(user.id);
        print("finish api call");

        _showSuccessDialog();
      } else {
        _showErrorDialog();
      }
    } catch (e) {
      print('회원가입 중 오류가 발생했습니다: $e');
    }
  }

  void _showSuccessDialog() {

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('축하합니다!'),
        content: Text('회원가입이 완료되었습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToLoginPage();
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('오류'),
        content: Text('모든 필수 정보를 입력해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  void _navigateToLoginPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
  }
}
