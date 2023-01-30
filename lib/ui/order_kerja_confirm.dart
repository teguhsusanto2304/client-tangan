import 'dart:convert';

import 'package:client/ui/component/component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../conf.dart';
import '../model/categories_model.dart';

class OrderKerjaConfirmPage extends StatefulWidget {
  final Datum data;

  const OrderKerjaConfirmPage({Key? key, required this.data}) : super(key: key);

  @override
  State<OrderKerjaConfirmPage> createState() => OrderKerjaConfirmState();
}

class OrderKerjaConfirmState extends State<OrderKerjaConfirmPage> {
  late SharedPreferences logindata;
  late String username;
  late String token;
  late int balance;
  @override
  void initState() {
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      token = logindata.getString('token')!;
    });
  }
  void _order() async {
    try {
      http.Response res = await http.post(
        Uri.parse(LOGIN),
        body: {
          "id": "fbb0eb28-a280-4219-b4d4-ffea9e814b0e",
          "address_id":"d0997ec4-3268-483d-930f-d21619eaf54b",
          "duration": {
            "60": 100000
          },
          "options": [
            {
              "title": "Jenis",
              "options": [
                "Manual"
              ]
            },
            {
              "title": "Type",
              "options": [
                "Suv"
              ]
            }
          ],
          "note": "Perjalan dalam kota bandung"
        },
      );
      if(res.statusCode != 200) {
        Map data = jsonDecode(res.body);
        ViewDialogs.alertDialog(
          context,
          data['message'],
        );
      } else {
        Map data = jsonDecode(res.body)['data'];
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
      //backgroundColor: Color(0xffF5F5F5),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 10.0, right: 10.0),
                      child: Column(children: <Widget>[
                        titleHeader2(titORDERKERJA, context),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Total Payment',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xff515252)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Rp. " +
                                  NumberFormat("###,###", "en_US")
                                      .format(widget.data.price),
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff515252))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Row(children: [
                              Container(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    40,
                                child: Text('Waktu',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color(0xff515252))),
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  //width:(MediaQuery.of(context).size.width/2),
                                  child: Text('14 January, 2021, 16:00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff515252))))
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              Container(
                                width: (MediaQuery.of(context).size.width / 2) +
                                    85,
                                child: const Text('Lama Pengerjaan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color(0xff515252))),
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  //width:(MediaQuery.of(context).size.width/2),
                                  child: const Text('12 Jam',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff515252))))
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              Container(
                                width: (MediaQuery.of(context).size.width / 2) +
                                    85,
                                child: const Text('Tipe kendaraan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color(0xff515252))),
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  //width:(MediaQuery.of(context).size.width/2),
                                  child: const Text('Manual',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff515252))))
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              Container(
                                width: (MediaQuery.of(context).size.width / 2) +
                                    85,
                                child: const Text('Perjalanan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color(0xff515252))),
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  //width:(MediaQuery.of(context).size.width/2),
                                  child: const Text('Antar kota',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff515252))))
                            ])
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) + 30,
                              child: Text('Total',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xff515252))),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                width: (MediaQuery.of(context).size.width / 2) -
                                    79,
                                child: Text('Rp. 200.000',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xff515252)))),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Deskripsi Pekerjaan',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xff515252))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                               left: 10.0, right: 10.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Perjalanan dari jakarta ke bandung, saya butuh yang tau jalan juga',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Color(0xff515252))),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text(
                              "Lanjutkan",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(CLWHITE)),
                            ),
                            onPressed: () {
                              //Navigator.pushReplacement(
                              //  context,
                              //  MaterialPageRoute(builder: (context) => const SignIn()),
                              //);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: const Color(CLGREY),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                          ),
                        )
                      ]))))),
    );
  }
}
