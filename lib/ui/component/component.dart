import 'dart:developer';
import 'dart:ffi';

import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:client/conf.dart';
import 'package:flutter/material.dart';

class voucherCard extends StatelessWidget {
  const voucherCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 63,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: const Color(0xffF26A4A),
            child: ListTile(
              leading: const Icon(
                Icons.people_alt,
                color: Colors.white,
              ),
              title: const Text('Ajak temen dapet voucher',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              selected: true,
              onTap: () {},
            )));
  }
}

class balanceCard extends StatelessWidget {
  final int balance;

  balanceCard({this.balance = 0});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: const Color(0xff515252),
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Saldo Saat ini',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'Rp. ${NumberFormat("###,###", "en_US").format(balance)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 33,
                                  color: Color(0xffF4EE42))),
                        )),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xffF4EE42),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    )),
                                child: const Text(
                                  "Lihat History",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  log("history");
                                },
                              )),
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff515252),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    side: const BorderSide(
                                      width: 2.0,
                                      color: Color(0xffF4EE42),
                                    )),
                                child: const Text("Topup",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffF4EE42))),
                                onPressed: () {
                                  log("topup");
                                },
                              )),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(5),
    );
  }
}

Widget divider({double height = 5.0}) {
  return SizedBox(height: height);
}

Widget textEmail(TextEditingController emailController) {
  return Padding(
    padding:
        const EdgeInsets.only(left: 19.0, right: 19.0, top: 20, bottom: 30),
    //padding: EdgeInsets.symmetric(horizontal: 19),
    child: TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: titEMAIL,
          //errorText: 'Email tidak valid',
          hintText: titPHEMAIL),
    ),
  );
}

Widget textPassword(TextEditingController passwordController) {
  return Padding(
    padding: const EdgeInsets.only(left: 19.0, right: 19.0, top: 0, bottom: 30),
    //padding: EdgeInsets.symmetric(horizontal: 19),
    child: TextField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: titPASSWORD,
          hintText: titPHPASSWORD),
    ),
  );
}

Widget titleHeader(title) {
  return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff515252)),
        ),
      ));
}

Widget titleHeader2(title, ctx) {
  return Align(
      alignment: Alignment.centerLeft,
      child: Row(children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: const Color(0xffF1EEEE),
          child: SizedBox(
              height: 50,
              width: 50,
              //color: Color(0xffF1EEEE),
              child: IconButton(
                icon: SvgPicture.asset('assets/images/back.svg'),
                iconSize: 90,
                onPressed: () {
                  Navigator.pop(ctx);
                },
              )),
        ),
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff515252)),
        ),
      ]));
}

Widget titleSubHeader(title) {
  return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xff515252)),
        ),
      ));
}

Widget logoSignin(BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
    child: Center(
      child: SizedBox(
          width: MediaQuery.of(ctx).size.width / 0.5,
          height: MediaQuery.of(ctx).size.height / 3,
          child: Image.asset(PATH_LOGIN)),
    ),
  );
}

Future showAlert(String title, BuildContext ctx) {
  return showDialog(
    context: ctx,
    builder: (ctx) {
      return AlertDialog(
        content: Text(title),
      );
    },
  );
}

enum ViewDialogsAction { yes, no }

class ViewDialogs {
  static Future<ViewDialogsAction> yesOrNoDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(ViewDialogsAction.no),
              child: const Text('Not Necessary'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ViewDialogsAction.yes),
              child: const Text(
                'Want to be Notified',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : ViewDialogsAction.no;
  }

  static Future<ViewDialogsAction> alertDialog(
    BuildContext context,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          //backgroundColor: Colors.amberAccent,
          backgroundColor: Colors.orange[100],
          title: const Text(
            "Peringatan",
            style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
          content: Text(body),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(ViewDialogsAction.no),
              style: ElevatedButton.styleFrom(primary: Colors.grey),
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
    return (action != null) ? action : ViewDialogsAction.no;
  }
}

class OnboardingSlider extends StatelessWidget {
  String image;
  String title;
  String desc;
  int currentIndex = 0;
  int slideLength;

  OnboardingSlider(
      {Key? key,
      required this.image,
      required this.title,
      required this.desc,
      required this.currentIndex,
      required this.slideLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // contains container
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // image given in slider
          Image(image: AssetImage(image)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              slideLength,
              (index) => buildDot(index, context),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 30, top: 0, right: 30),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xff515252)),
                  ))),
          Padding(
              padding: const EdgeInsets.only(left: 30, top: 5, right: 30),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    desc,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Color(0xff515252)),
                  ))),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  // container created for dots
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffF4EE42),
      ),
    );
  }
}
