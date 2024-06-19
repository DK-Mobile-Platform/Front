import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mobileplatform_project/viewModel/signupPage_viewModel.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SignUpForm(),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedCountry = 'choose'.tr();
  String nameError = '';
  String idError = '';
  String passwordError = '';

  void _handleInputChange(BuildContext context, String value, String field) {
    final viewModel = Provider.of<SignUpViewModel>(context, listen: false);
    bool isAllowed = RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);

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
      return;
    }

    setState(() {
      value = value.replaceAll(' ', '');
      switch (field) {
        case 'username':
          viewModel.user.username = value;
          nameError = '';
          break;
        case 'id':
          viewModel.user.id = value;
          viewModel.user.userId = value;
          idError = '';
          break;
        case 'password':
          viewModel.user.password = value;
          passwordError = '';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpViewModel>(context);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50.0),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'NAME',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            CustomErrorDisplay(errorMessage: nameError),
            Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextFormField(
                onChanged: (value) {
                  _handleInputChange(context, value, 'username');
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')),
                ],
                decoration: InputDecoration(
                  labelText: 'name'.tr(),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  if (value.contains(' ')) {
                    return '공백을 포함할 수 없습니다.';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'ID',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            CustomErrorDisplay(errorMessage: idError),
            Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextFormField(
                onChanged: (value) {
                  _handleInputChange(context, value, 'id');
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')),
                ],
                decoration: InputDecoration(
                  labelText: 'id'.tr(),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'ID is required';
                  }
                  if (value.contains(' ')) {
                    return '공백을 포함할 수 없습니다.';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'PASSWORD',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            CustomErrorDisplay(errorMessage: passwordError),
            Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextFormField(
                onChanged: (value) {
                  _handleInputChange(context, value, 'password');
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')),
                ],
                decoration: InputDecoration(
                  labelText: 'password'.tr(),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password is required';
                  }
                  if (value.contains(' ')) {
                    return '공백을 포함할 수 없습니다.';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                SizedBox(width: 60),
                Text(
                  'COUNTRY',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            setState(() {
                              selectedCountry = 'korea'.tr();
                              viewModel.user.country = selectedCountry;
                            });
                            Navigator.pop(context);
                          },
                          child: Text('korea'.tr()),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            setState(() {
                              selectedCountry = 'china'.tr();
                              viewModel.user.country = selectedCountry;
                            });
                            Navigator.pop(context);
                          },
                          child: Text('china'.tr()),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel'.tr()),
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCountry,
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.0),
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
                    if (_formKey.currentState!.validate()) {
                      viewModel.signUp();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Text(
                    'sign_up_button'.tr(),
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
    );
  }
}

class CustomErrorDisplay extends StatelessWidget {
  final String errorMessage;

  CustomErrorDisplay({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return errorMessage.isNotEmpty
        ? Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        children: [
          Icon(Icons.error, color: Colors.red),
          SizedBox(width: 10),
          Text(
            errorMessage,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ),
    )
        : Container();
  }
}
