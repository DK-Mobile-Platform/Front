import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobileplatform_project/view/home/homePage.dart';
import 'package:provider/provider.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';
import 'package:mobileplatform_project/viewModel/homePage_viewModel.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Consumer<HomePageViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.result.loading) {
              return Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
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
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return HomePage();
            }
          }
      ),
    );
  }
}