import 'dart:convert';

import 'package:client/ui/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../conf.dart';
import '../model/categories_model.dart';

class OrderKerjaPage extends StatefulWidget {
  final Datum data;

  const OrderKerjaPage({Key? key, required this.data}) : super(key: key);

  @override
  State<OrderKerjaPage> createState() => OrderKerjaState();
}
Future <List<Durasi>> fetchData(Datum dt) async {
  List jsonResponse = jsonDecode(dt.duration.toString());
    return jsonResponse.map((data) => Durasi.fromJson(data)).toList();
}
class OrderKerjaState extends State<OrderKerjaPage> {
  late List<Map> aOpsi2;
  List<Map> aOpsi = [
    {
      "title": "Jenis",
      "options": [
        "Matic",
        "Manual"
      ],
      "isChecked":false
    },
    {
      "title": "Type",
      "options": [
        "Suv",
        "Sedan"
      ],
      "isChecked":false
    }
  ];
  List<Map> aDurasi = [
    {
      "time": 60,
      "price": 100000,
      "isChecked":false
    },
    {
      "time": 90,
      "price": 150000,
      "isChecked":false
    },
    {
      "time": 120,
      "price": 200000,
      "isChecked":false
    }
  ];
  //aDurasi.forEach((k, v) => print("Key : $k, Value : $v"));
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
                        padding:
                            const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                        child: Column(children: <Widget>[
                           titleHeader2(titORDERKERJA, context),
                          const SizedBox(height: 20,),
                          Align(
                            alignment: Alignment.center,
                            child:SvgPicture.string(widget.data.icon,height: 100,width: 100,fit: BoxFit.fitHeight,),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child:Text("Rp. "+NumberFormat("###,###", "en_US").format(widget.data.price),style: const TextStyle(fontSize:17,fontWeight:FontWeight.bold,color: Color(0xff515252))),
                          ),
                          const SizedBox(height: 40,),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child:Text('Tipe Pekerjaan',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Color(0xff515252)),),
                          ),
                          TextField(
                            enabled: false,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: const Color(0xffE5E5E5),
                                labelText: widget.data.name,
                                hintText: 'Masukan password anda'),
                          ),
                          Column(
                              children: aDurasi.map((dtDurasi) {
                                return CheckboxListTile(
                                    value: dtDurasi["isChecked"],
                                    title: Text(dtDurasi["time"].toString()),
                                    onChanged: (newValue) {
                                      setState(() {
                                        dtDurasi["isChecked"] = newValue;
                                      });
                                    });
                              }).toList()),

                        ]))))));
  }
}
