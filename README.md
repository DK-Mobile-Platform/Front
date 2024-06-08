# 🌐 Front with FLUTTER

## 실행영상
<img src= "https://github.com/DK-Mobile-Platform/Front/assets/94334477/bf964c4b-acfe-4873-92b5-4e771491c369" width= "200" height="400">

## MVVM 구조로 코드를 작성
* dataSource : 데이터를 가져오는 영역
* dbHelper : Sqlite 사용을 위한 DB 제어
* model : 데이터 설계
* view(front/history/home/setting/widget) : 사용자에게 보여지는 영역
* viewModel : view의 상태 관리
  
<br/><br/>
## SQLite를 통한 회원가입/로그인/로그아웃 구현 [SQLite](https://www.sqlite.org/)
<pre><code>
static Future<void> _initDatabaseFactory() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfiWeb;
  }

  static initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id TEXT PRIMARY KEY, username TEXT, password TEXT, name TEXT, country TEXT, userID TEXT)",
        );
      },
      version: 1,
    );
  }
</code></pre>

<br/><br/>
## input 값 예외처리
* FilteringTextInputFormatter를 이용 [공식문서 참고](https://api.flutter.dev/flutter/services/FilteringTextInputFormatter-class.html)
<pre><code>
inputFormatters: [
  FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]+$')),
],
  
 ...
  
bool isAllowed = RegExp(r'^[a-zA-Z]+$').hasMatch(value);

if (!isAllowed) {
    setState(() {
      switch (field) {
        case 'username':
          nameError = '올바른 입력값을 넣어주세요.';
          break;
        case 'id':
          idError = '올바른 입력값을 넣어주세요.';
          break;
        case 'password':
          passwordError = '올바른 입력값을 넣어주세요.';
          break;
      }
    });
}
</code></pre>

<br/><br/>
## 화면 전환 애니메이션
* PageRouteBuilder를 이용 [공식문서 참고](https://docs.flutter.dev/cookbook/animation/page-route-animation)
* 서서히 나타나도록 
<pre><code>
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1500),
      pageBuilder: (context, animation, secondaryAnimation) => MiddlePage(user: user),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.easeInOut;

        //화면 전환 애니메이션
        var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animation,
          curve: Interval(0.0, 0.5, curve: curve), // 0부터 0.5까지는 흐려짐
        ));

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
    ),
  );
}
</code></pre>


<br/><br/>
## 10초마다 넘겨지는 광고바
* carousel_slider 패키지 이용 [carousel_slider](https://pub.dev/packages/carousel_slider)
* 여러 옵션을 지정할 수 있음
<pre><code>
options: CarouselOptions(
  height: 100, 
  viewportFraction: 1, 
  initialPage: 0,
  enableInfiniteScroll: true, //무한 스크롤 활성화
  autoPlay: true, //자동 재생 활성화
  autoPlayInterval:
  Duration(seconds: 10), //자동 재생 간격
  autoPlayAnimationDuration:
  Duration(milliseconds: 8000), //자동 재생 애니메이션 시간
  autoPlayCurve: Curves.fastOutSlowIn,
  scrollDirection: Axis.horizontal,
),
</code></pre>

<br/><br/>
## 아코디언 형식으로 요약 내용 보기
* isExpand 변수와 ExpansionPanel을 이용 [공식문서 참고](https://api.flutter.dev/flutter/material/ExpansionPanel-class.html)
<pre><code>
Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  child: ExpansionPanelList(
    expandedHeaderPadding: EdgeInsets.zero,
    expansionCallback: (int index, bool isExpanded) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    },
    children: [
      ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: Text(
             _isExpanded? aiViewModel.aiSummary?.full_text_data ?? 'no_full'.tr()
                  :   aiViewModel.aiSummary!.text_data ?? 'no_summary'.tr(),
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          );
        },
        body: _isExpanded?
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            "",
            style: TextStyle(fontSize: 0.0),
            textAlign: TextAlign.center,
          ),
        )
        : Container(),
        isExpanded: _isExpanded,
      ),
    ],
  ),
),

</code></pre>

<br/><br/>
## 언어 설정(한국어/중국어)
* easy_localization 패키지 이용 [easy_localization](https://pub.dev/packages/easy_localization)
<pre><code>
runApp(
  EasyLocalization(
    supportedLocales: [Locale('ko', 'KR'), Locale('zh', 'CN')],
    path: 'assets/translations',
    fallbackLocale: Locale('ko', 'KR'), // 기본 언어
    child: const MyApp(),
  ),
);
</code></pre>

<br/><br/>
## 로딩 바 
* flutter_spinkit 패키지 이용 [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)
<pre><code>
SpinKitWave(
  itemBuilder: (context, index) {
    return const DecoratedBox(
      decoration: BoxDecoration(color: Colors.green),
    );
  },
),
</code></pre>



