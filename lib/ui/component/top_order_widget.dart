import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:client/model/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../conf.dart';

class TopOrderCategoriesWidget extends StatefulWidget {
  const TopOrderCategoriesWidget({Key? key}) : super(key: key);

  @override
  _TopOrderCategoriesScreenState createState() => _TopOrderCategoriesScreenState();
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
var arrColor = [Colors.purple,Colors.grey,Colors.amberAccent,Colors.blueAccent,Colors.deepOrange];

class _TopOrderCategoriesScreenState extends State<TopOrderCategoriesWidget> {
  late Future <List<Datum>> futureData;
  @override
  void initState() {
    futureData = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 100,
        child: FutureBuilder <List<Datum>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Datum>? data = snapshot.data;
              return
                SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                              width: MediaQuery.of(context).size.width-20,
                              child:Card(
                                color: arrColor[index],
                                elevation: 6,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children:  [
                                    Padding(
                                        padding: const EdgeInsets.all(10),
                                        child:SizedBox(
                                          width: 60,
                                          child: SvgPicture.string(data![index].icon,height: 60,width: 60,fit: BoxFit.fitHeight,color: Colors.white,),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(top:10,bottom: 10),
                                        child:Column(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width-150,
                                              child:  Text(data[index].name,textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white),),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context).size.width-150,
                                                child:Badge(
                                                    toAnimate: false,
                                                    shape: BadgeShape.square,
                                                    badgeColor: Colors.white30,
                                                    borderRadius: BorderRadius.circular(8),
                                                    badgeContent:Text("Rp. "+NumberFormat("###,###", "en_US").format(data[index].price)+"/Jam",textAlign: TextAlign.start,style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 12,color: Colors.white),)
                                                )
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width-150,
                                              child:  Text(data[index].note,textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12,color: Colors.white),),
                                            ),
                                            //Text('butuh teman mengobrol ketika kamu lagi sibuk? sekedar ngopi juga boleh..',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white),),
                                          ],
                                        ))
                                  ],
                                ),
                              )
                          );
                        }
                    ));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }
}

