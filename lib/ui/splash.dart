import 'dart:async';
import 'dart:developer';
import 'package:client/ui/dashboard.dart';
import 'package:client/ui/onboarding.dart';
import 'package:client/conf.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    checkUserLogged();
  }

  void checkUserLogged() async {
    logindata = await SharedPreferences.getInstance();
    if(logindata.getBool(sesLOGIN) != null){
      newuser = logindata.getBool(sesLOGIN)!;
    } else {
      newuser = false;
    }
    //newuser = (logindata.getBool('login') ?? true);
    if (newuser == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const DashboardPage();
      }));
    } else {
      Timer(
          const Duration(seconds: 10),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const OnboardingPage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    var assetsImage = const AssetImage(
        PATH_LOGO); //<- Creates an object that fetches an image.
    var image = Image(
        image: assetsImage,
        height: 300); //<- Creates a widget that displays an image.

    return MaterialApp(
      title: TITLE,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: clWHITEORI),
          child: Center(
            child: image,
          ),
        ), //<- place where the image appears
      ),
    );
  }
}
