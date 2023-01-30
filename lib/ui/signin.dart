import 'dart:convert';
import 'dart:developer';

import 'package:client/conf.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'component/component.dart';
import 'dashboard.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  void checkUserLogged() async {
    logindata = await SharedPreferences.getInstance();
    if(logindata.getBool('login') != null){
      newuser = logindata.getBool('login')!;
    } else {
      newuser = false;
    }
    print(newuser);
    if (newuser == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return  const DashboardPage();
      }));
    }
  }
  @override
  void initState() {
    super.initState();
    checkUserLogged();
  }
  void _signin() async {
    try {
      http.Response res = await http.post(
        Uri.parse(LOGIN),
        body: {'token':GENERAL_TOKEN,'email': emailController.text, 'password': passwordController.text},
      );
      if(res.statusCode != 200) {
        Map data = jsonDecode(res.body);
        ViewDialogs.alertDialog(
          context,
          data['message'],
        );
      } else {
        Map data = jsonDecode(res.body)['data'];
        log(data.toString());
        logindata.setBool(sesLOGIN, true);
        logindata.setString(sesTOKEN, data[sesTOKEN]);
        http.Response resProfile = await http.get(
          Uri.parse(PROFILE),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${data[sesTOKEN]}',
          },
        );
        Map dataProfile = jsonDecode(resProfile.body)['data'];
        logindata.setString(sesNAME, dataProfile[sesNAME]);
        logindata.setString(sesEMAIL, emailController.text);
        logindata.setString(sesPHONENUMBER, dataProfile[sesPHONENUMBER]);
        http.Response resBalance = await http.get(
          Uri.parse(BALANCE),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${data[sesTOKEN]}',
          },
        );
        Map dataBalance = jsonDecode(resBalance.body);
        logindata.setInt(sesBALANCE, dataBalance[sesBALANCE]);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return  DashboardPage();
        }));
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
            child: Column(
              children: <Widget>[
                logoSignin(context),
                Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: titleHeader(titLOGIN)),
                textEmail(emailController),
                textPassword(passwordController),
                SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 19.0, top: 0.0, right: 19.0, bottom: 5.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xffF4EE42),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          //onPressed: () {  },
                          child: const Text(
                            titSUBMIT,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff515252)),
                          ),
                          onPressed: () async {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ViewDialogs.alertDialog(
                                context,
                                titLOGINVALIDATION,
                              );
                            } else {
                              _signin();
                            }
                          }),
                    )),
              ],
            )),
      ),
    );
  }
}

void loginProcedure(
    SharedPreferences logData,
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext ctx) async {
  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    final action = await ViewDialogs.alertDialog(
      ctx,
      titLOGINVALIDATION,
    );
  } else {
    http.Response res = await http.post(
      Uri.parse(LOGIN),
      body: {
        'token': '4|9ijulRBZlDxkSqxpTvcjIbF0POEav8n5aCxjq0WK',
        'email': emailController.text,
        'password': passwordController.text
      },
    );
    if (res.statusCode != 200) {
      Map data = jsonDecode(res.body);
      final action = await ViewDialogs.alertDialog(
        ctx,
        data['message'],
      );
      ;
    } else {
      Map data = jsonDecode(res.body)['data'];
      logData.setBool('login', true);
      logData.setString('token', data['token']);
      http.Response resProfile = await http.get(
        Uri.parse(PROFILE),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${data['token']}',
        },
      );
      Map dataProfile = jsonDecode(resProfile.body)['data'];
      logData.setString('name', dataProfile['name']);
      //log(logData.getString("name").toString());
      //log(logData.getBool("login").toString());
      http.Response resBalance = await http.get(
        Uri.parse(BALANCE),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${data['token']}',
        },
      );
      Map dataBalance = jsonDecode(resBalance.body);
      logData.setInt('balance', dataBalance['balance']);
      Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (context) {
        return const DashboardPage();
      }));
    }
    /**Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (context) {
        return const DashboardPage();
        })
        );**/
  }

//loadingLogin = true;
//notifyListeners();

//loadingLogin = false;
//notifyListeners();
}
