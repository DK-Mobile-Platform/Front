import 'package:flutter/material.dart';
import 'package:mobileplatform_project/view/front/signupPage.dart';
import 'package:mobileplatform_project/view/widget/bottomNavBar.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/logo.jpeg',
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 10),
                Text(
                  'DAKUA',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                // controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'ID',
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                // controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 60,
              width: 300,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.greenAccent, Colors.blueGrey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: ElevatedButton(
                  onPressed: () => _navigateToMainPage(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Text(
                    '로그인하기',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '아직 회원이 아니라면?',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () => _navigateToSignUpPage(context),
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _navigateToMainPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BottomNavBar()),
  );
}

void _navigateToSignUpPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignUpPage()),
  );
}
