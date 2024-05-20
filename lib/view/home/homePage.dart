import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';
import 'package:mobileplatform_project/view/home/resultPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  bool _dataReceived = false;
  String? _attachedFileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: _loading
                ? Column( /////////////////////////////로딩 화면 시작
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '요약 생성 중입니다. \n 잠시만 기다려 주세요.',
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  SpinKitWave(
                    itemBuilder: (context, index) {
                      return const DecoratedBox(
                        decoration: BoxDecoration(color: Colors.green),
                      );
                    },
                  ),
                ]
            )


                : _dataReceived /////////////////////////////요약 결과 화면 시작
                ? Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _dataReceived = false;
                          _loading = false;
                        });
                      },
                      child: Text(
                        '다른 파일 올리기',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  width: 230,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _attachedFileName != null
                          ? '$_attachedFileName'
                          : '첨부한 파일이 없습니다.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 30),
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
                      onPressed: () => _saveRecord(context),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Text(
                        '기록 저장하기',
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: ()=> _navigateToResultPage(context),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '줄글로 보기',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ],
            )


            : Column( ///////////////////////////////// 기본 홈 화면 시작
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: CarouselSlider(
                    items: [
                      Center(
                          child: Text(
                            '요약하는데 약 2분 정도 시간이 걸릴 수 있어요!',
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Center(
                          child: Text(
                            'DAKUA는 수업 요약에 탁월해요',
                            style: TextStyle(fontSize: 18.0),
                          )),
                      Center(
                          child: Text(
                            '광고문의 dakua@dankook.ac.kr',
                            style: TextStyle(fontSize: 18.0),
                          )),
                    ],
                    options: CarouselOptions(
                      height: 50,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 10),
                      autoPlayAnimationDuration:
                      Duration(milliseconds: 8000),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                SizedBox(height: 100.0),
                Text(
                  '녹음 파일 첨부',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => _attachFile(context),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: SizedBox(
                    width: 230,
                    height: 50,
                    child: Center(
                      child: Text(
                        _attachedFileName != null
                            ? '$_attachedFileName'
                            : '첨부하기',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 150.0),
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
                      onPressed: () {
                        setState(() {
                          _loading = true;
                          //백엔드로 부터 데이터를 가져왔는지 확인 하는 코드로 변경해야 함
                          Future.delayed(Duration(seconds: 5), () {
                            setState(() {
                              _dataReceived = true;
                              _loading = false;
                            });
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Text(
                        '요약 생성하기',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 파일 첨부 코드
  void _attachFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _attachedFileName = file.name;
      });
      print('Selected file: ${file.name}');
    } else {
      print('File picking canceled.');
    }
  }

  //파일 저장 코드
  void _saveRecord(BuildContext context) async {
    String folderName = ''; // 선택된 폴더 이름
    String fileName = ''; // 저장할 파일 이름

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("요약 기록을 저장하시겠습니까?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("저장 폴더 선택"),
              TextFormField(
                onChanged: (value) {
                  folderName = value;
                },
              ),
              SizedBox(height: 10),
              Text("저장 이름"),
              TextFormField(
                onChanged: (value) {
                  fileName = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveToFile(folderName, fileName);
              },
              child: Text("예"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("아니요"),
            ),
          ],
        );
      },
    );
  }

  void _saveToFile(String folderName, String fileName) {
    // 추후 파일 저장 코드 작성해야 됨
    print('Folder Name: $folderName');
    print('File Name: $fileName');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("저장되었습니다"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("확인"),
            ),
          ],
        );
      },
    );
  }


  void _navigateToResultPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultPage()),
    );
  }

}
