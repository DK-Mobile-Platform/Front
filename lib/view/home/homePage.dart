import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../../dataSource/aiProcess_dataSource.dart';
import '../../dataSource/fileAttach_dataSource.dart';
import '../../model/user.dart';
import '../../viewModel/aiProcess_viewModel.dart';
import '../../viewModel/fileAttach_viewModel.dart';
import '../widget/appBar.dart';
import 'resultDetailPage.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AIProcessViewModel>(
          create: (context) => AIProcessViewModel(AIProcessDataSource()),
        ),
        ChangeNotifierProvider<FileAttachViewModel>(
          create: (context) => FileAttachViewModel(FileAttachDataSource(), widget.user),
        ),
      ],
      child: Consumer2<AIProcessViewModel, FileAttachViewModel>(  //User
        builder: (context, aiViewModel, fileAttachViewModel, child) { //context, user, child
          return ChangeNotifierProvider<FileAttachViewModel>(
            create: (context) => FileAttachViewModel(FileAttachDataSource(), widget.user),
            child: Scaffold(
              appBar: AppBarWidget(),
              body: Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: Consumer2<AIProcessViewModel, FileAttachViewModel>(
                      builder: (context, aiViewModel, fileAttachViewModel, child) {
                        if (aiViewModel.dataReceived) {
                          return Column(
                            children: [
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      // aiViewModel.resetDataReceived();
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
                                    aiViewModel.aiSummary?.summaryText != null
                                        ? aiViewModel.aiSummary!.summaryText!
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
                                child: aiViewModel.aiSummary?.image != null
                                    ? Image.network(aiViewModel.aiSummary!.image!)
                                    : Container(),
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
                                    onPressed: () => (context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
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
                                    onPressed: () => _navigateToResultPage(context),
                                    child: Row(
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
                          );
                        } else {
                          return Column(
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
                                    autoPlayAnimationDuration: Duration(milliseconds: 8000),
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
                                onPressed: () => fileAttachViewModel.selectFile(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
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
                                      fileAttachViewModel.filePath != null
                                          ? '파일 선택됨: ${fileAttachViewModel.filePath}'
                                          : '파일 첨부하기',
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
                                      if (fileAttachViewModel.filePath != null) {
                                        print("ai process start");
                                        aiViewModel.postUserId(widget.user.userId!); // 수정
                                      } else {
                                        print("No file selected.");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
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
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToResultPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultDetailPage()),
    );
  }
}
