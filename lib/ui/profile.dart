import 'package:client/ui/edit_profile.dart';
import 'package:client/ui/signin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../conf.dart';
import 'component/component.dart';

class ProfilePage extends StatelessWidget {
  SharedPreferences data;

  ProfilePage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: ListView(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: const Color(0xff515252),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditProfilePage(data: data,)),
                                );
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.amberAccent,
                                minRadius: 35.0,
                                child: Icon(
                                  Icons.edit,
                                  size: 30.0,
                                ),
                              )),
                          const CircleAvatar(
                            backgroundColor: Colors.white70,
                            minRadius: 60.0,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(
                                  'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                            ),
                          ),
                          GestureDetector(
                              onTap: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                await preferences.clear();
                                preferences.setBool(sesLOGIN, false);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const SignIn();
                                }));
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.amberAccent,
                                minRadius: 35.0,
                                child: Icon(
                                  Icons.logout,
                                  size: 30.0,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.getString(sesNAME)!,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Customer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Colors.deepOrange.shade300,
                        child: ListTile(
                          title: Text(
                            'Rp. ${NumberFormat("###,###", "en_US").format(data.getInt(sesBALANCE)!)}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: const Text(
                            titBALANCE,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        child: const ListTile(
                          title: Text(
                            'Rp. 0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            'Transaksi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(children: <Widget>[
                  ListTile(
                    title: Text(
                      titEMAIL,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      data.getString(sesEMAIL)!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                ]),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text(
                        titPHONENUMBER,
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data.getString(sesPHONENUMBER)!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
