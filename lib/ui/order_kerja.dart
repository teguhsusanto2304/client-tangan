import 'dart:convert';

import 'package:client/ui/component/component.dart';
import 'package:client/ui/order_kerja_confirm.dart';
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

Future<List<Durasi>> fetchData(Datum dt) async {
  List jsonResponse = jsonDecode(dt.duration.toString());
  return jsonResponse.map((data) => Durasi.fromJson(data)).toList();
}

class OrderKerjaState extends State<OrderKerjaPage> {
  late Future<StaffService> staffService;

  @override
  void initState() {
    staffService = getStaffService();
    super.initState();
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
                        Align(
                          alignment: Alignment.center,
                          child: SvgPicture.string(
                            widget.data.icon,
                            height: 100,
                            width: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              "Rp. " +
                                  NumberFormat("###,###", "en_US")
                                      .format(widget.data.price),
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff515252))),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        FutureBuilder<StaffService>(
                            future: staffService,
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                final saff = snapshot.data!;

                                return ListView(
                                  shrinkWrap: true,
                                  children: [
                                    if (saff.service1.isNotEmpty)
                                      StaffServiceTile(
                                        title: Text(
                                          'Title for Service 1',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        services: saff.service1,
                                      ),
                                    if (saff.service2.isNotEmpty)
                                      StaffServiceTile(
                                        title: Text(
                                          'Title for Service 2',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        services: saff.service2,
                                      ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return const Text(
                                    'Error on loaad data. Try again later.');
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => OrderKerjaConfirmPage(data: widget.data,)),
                                );

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

class StaffServiceTile extends StatelessWidget {
  const StaffServiceTile({
    Key? key,
    required this.title,
    required this.services,
  }) : super(key: key);

  final Widget title;
  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: title),
        for (var person in services)
          ListTile(
            title: Text(
              '${person.firstname} ${person.lastname}',
            ),
          ),
      ],
    );
  }
}

class StaffService {
  StaffService({this.service1 = const [], this.service2 = const []});

  List<Service> service1, service2;

  factory StaffService.fromJson(String str) {
    return StaffService.fromMap(json.decode(str));
  }

  String toJson() => json.encode(toMap());

  factory StaffService.fromMap(Map<String, dynamic> json) => StaffService(
        service1:
            List<Service>.from(json["service1"].map((x) => Service.fromMap(x))),
        service2:
            List<Service>.from(json["service2"].map((x) => Service.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "service1": List<dynamic>.from(service1.map((x) => x.toMap())),
        "service2": List<dynamic>.from(service2.map((x) => x.toMap())),
      };
}

class Service {
  Service({this.firstname, this.lastname});

  String? firstname, lastname;

  factory Service.fromJson(String str) => Service.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Service.fromMap(Map<String, dynamic> json) => Service(
        firstname: json["firstname"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toMap() => {
        "firstname": firstname,
        "lastname": lastname,
      };
}

Future<StaffService> getStaffService() async {
  await Future.delayed(const Duration(seconds: 2));
  return StaffService.fromMap(
      data); // <- use fromJson if you load data from the JSON.
}

final data = <String, List<Map<String, String>>>{
  "service1": [
    {"firstname": "Peter", "lastname": "Smith"},
    {"firstname": "Paul", "lastname": "Johnson"}
  ],
  "service2": [
    {"firstname": "Mary", "lastname": "Williams"},
    {"firstname": "Guy", "lastname": "Brown"}
  ]
};
