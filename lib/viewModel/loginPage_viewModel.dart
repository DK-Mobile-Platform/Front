import 'package:flutter/material.dart';
import 'package:mobileplatform_project/dbHelper/user_dbHelper.dart';
import 'package:mobileplatform_project/model/user.dart';
import 'package:mobileplatform_project/view/widget/bottomNavBar.dart';

class LoginViewModel extends ChangeNotifier {
  late User user;
  late BuildContext context;

  LoginViewModel(this.context) {
    user = User(id: '', username: '', password: '', country: '',userId:'');
  }

  void login() async {
    User? loggedInUser =
    await DBHelper.getUser(user.username, user.password);
    if (loggedInUser != null) {
      user.userId = user.username; // 만약 로그인에 성공하면 userId를 할당
      _navigateToMainPage(context,user);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('로그인 실패'),
            content: const Text('아이디 또는 비밀번호가 잘못되었습니다.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  void _navigateToMainPage(BuildContext context,User user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar(user : user)),
    );
  }
}
