import 'package:flutter/material.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';

class HistoryDetailPage extends StatelessWidget {
  final String folder;
  final List<String> files;

  //나중에 homepage에서 저장하기 버튼 누를 때의 날짜를 가져와야 함
  final String creationDate = '2024.4.3 (수) 저장됨';

  const HistoryDetailPage({
    required this.folder,
    required this.files,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 100),
                Text(
                  '지난 기록',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15.0),
              color: Colors.grey[200],
              child: Text(
                "            전체    >    $folder",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: files.map((file) {
                return Container(
                  height: 100, // Increased height to accommodate both file name and creation date
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.lightGreen[100],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your button's onPressed logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen[100],
                      elevation: 0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              creationDate,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              file,
                              style: TextStyle(
                                fontSize: 23.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
