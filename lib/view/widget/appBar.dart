import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(37, 61, 70, 1),
      title: Row(
        children: [
          SizedBox(width: 55),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('assets/icons/top_logo.png'),
          ),
          SizedBox(width: 20),
          Text(
            'DAKUA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      leading: Container(), // 뒤로 가기 아이콘 없애기
    );
  }
}
