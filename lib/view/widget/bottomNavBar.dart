import 'package:flutter/material.dart';
import 'package:mobileplatform_project/model/user.dart';
import 'package:mobileplatform_project/view/home/homePage.dart';
import 'package:mobileplatform_project/view/history/historyPage.dart';
import 'package:mobileplatform_project/view/setting/settingPage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var _index = 1;
  late final User _user;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _pages = [
      HistoryPage(),
      HomePage(user: _user),
      SettingPage(),
    ];
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromRGBO(37, 61, 70, 1),
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          currentIndex: _index,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: '지난기록',
              icon: Icon(Icons.history),
            ),
            BottomNavigationBarItem(
              label:'홈',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label:'설정',
              icon: Icon(Icons.settings),
            ),
          ]
      ),
    );
  }
}
