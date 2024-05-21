import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';
import 'package:mobileplatform_project/view/front/loginPage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String selectedLanguage = '한국어';

  //로그아웃
  void logout() {

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false, // 현재 페이지 이후의 모든 페이지를 스택에서 제거
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              '시스템 언어 설정',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            setState(() {
                              selectedLanguage = '한국어';
                            });
                            Navigator.pop(context);
                          },
                          child: Text('한국어'),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            setState(() {
                              selectedLanguage = '중국어';
                            });
                            Navigator.pop(context);
                          },
                          child: Text('중국어'),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('취소'),
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedLanguage,
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 1,
              color: Colors.grey[300],
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            SizedBox(height: 20),
            CupertinoButton(
              onPressed: logout,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 10),
                  Text('로그아웃'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
