import 'dart:convert';
import 'package:client/conf.dart';
import 'package:client/model/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../order_kerja.dart';

class OrderCategoriesWidget extends StatefulWidget {
  const OrderCategoriesWidget({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}
Future <List<Datum>> fetchData() async {
  final response =
  await http.get(Uri.parse(JOBREFRENCE));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body)['data'];
    return jsonResponse.map((data) => Datum.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class _ChatScreenState extends State<OrderCategoriesWidget> {

  late Future <List<Datum>> futureData;


  @override
  void initState() {
    futureData = fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 190,
        child: FutureBuilder <List<Datum>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Datum>? data = snapshot.data;
              return
                ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                          height: 80,
                          child:Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: Colors.white,
                              child:ListTile(
                                leading: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: const Color(0xffF7ED43),
                                    child:SizedBox(
                                        height: 70,
                                        width: 50,
                                        child:Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child:SvgPicture.string(data![index].icon,height: 10,width: 10,fit: BoxFit.fitHeight,)))),
                                title: Text(data[index].name,style: const TextStyle(fontSize:14,fontWeight:FontWeight.bold,color: Color(0xff515252))),
                                trailing: const Icon(Icons.arrow_forward_ios,color: Color(0xff515252),),
                                subtitle: Text("Rp. "+NumberFormat("###,###", "en_US").format(data[index].price),style: const TextStyle(fontSize:14,fontWeight:FontWeight.normal,color: Color(0xff515252))),
                                selected: true,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => OrderKerjaPage(data: data[index],)),
                                  );
                                },
                              )));
                    }
                );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }
}

