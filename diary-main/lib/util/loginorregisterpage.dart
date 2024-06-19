import 'package:flutter/material.dart';
import 'package:diaryapp/loginpage.dart';

import 'package:diaryapp/registerpage.dart';

class LoginOrRegsterPage extends StatefulWidget {
  const LoginOrRegsterPage({super.key});

  @override
  State<LoginOrRegsterPage> createState() => _LoginOrRegsterPageState();
}

class _LoginOrRegsterPageState extends State<LoginOrRegsterPage> {

  //initially show login page
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages(){
    setState(() {
      showLoginPage =! showLoginPage;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(onTap: togglePages,);
    }
    else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
    return Container();
  }
}