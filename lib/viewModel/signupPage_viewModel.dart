import 'package:flutter/material.dart';
import 'package:mobileplatform_project/dbHelper/user_dbHelper.dart';
import 'package:mobileplatform_project/model/user.dart';

import '../view/front/loginPage.dart';

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
