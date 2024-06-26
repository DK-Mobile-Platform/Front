import 'package:flutter/material.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';

class ResultDetailPage extends StatefulWidget {
  const ResultDetailPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultDetailPage> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!isExpanded) ...[
                    Text(
                      '한줄 요약',
                      style: TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 100,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    SizedBox(height: 50.0),
                  ],
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '전체보기',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 10.0),
                      Stack(
                        children: [
                          Container(
                            height: isExpanded ? 500 : 250,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              icon: Icon(
                                isExpanded ? Icons.expand_less : Icons.expand_more, // 아이콘 변경
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
