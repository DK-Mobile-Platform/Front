import 'package:flutter/material.dart';
import 'package:mobileplatform_project/view/front/splashScreen.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();




  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ko', 'KR'), Locale('zh', 'CN')],
      path: 'assets/translations',
      fallbackLocale: Locale('ko', 'KR'), // 기본 언어
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Logo Page',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home:  SplashScreen(),
    );
  }
}
