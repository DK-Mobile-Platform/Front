import 'package:flutter/material.dart';
import 'package:mobileplatform_project/model/user.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';
import 'package:mobileplatform_project/view/history/historyDetailPage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> folders = ["기본 폴더"];
  List<String> files = ['파일1', '파일2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Text(
                '지난 기록',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              SizedBox(height: 10.0),
              Divider(
                thickness: 2.0,
                indent: 40.0,
                endIndent: 40.0,
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _addFolder(context);
                      },
                      icon: Icon(Icons.create_new_folder),
                      label: Text('새폴더'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 5.0,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                children: List.generate(folders.length, (index) {
                  String folderName = folders[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryDetailPage(folder: folderName, files: files,),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/file_image.png',
                          width: 70,
                          height: 70,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          folderName,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addFolder(BuildContext context) {
    String folderName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("새 폴더 추가"),
          content: TextField(
            onChanged: (value) {
              folderName = value;
            },
            decoration: InputDecoration(hintText: "폴더 이름"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (folderName.isNotEmpty) {
                  setState(() {
                    folders.add(folderName);
                  });
                }
              },
              child: Text("확인"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("취소"),
            ),
          ],
        );
      },
    );
  }
}
