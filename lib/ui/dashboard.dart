import 'package:client/ui/home.dart';
import 'package:client/ui/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => DashboardState();
}

class DashboardState extends State<DashboardPage> {
  int selectedIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  late SharedPreferences logindata;
  late String username;
  late String token;
  late int balance;
  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('name')!;
      token = logindata.getString('token')!;
      balance = logindata.getInt("balance")!;
    });
  }
  late List<StatelessWidget> widgetOptions = [
    HomePage(balance: logindata.getInt("balance")!,username: logindata.getString('name')!,),
    ProfilePage(data: logindata,),
    ProfilePage(data: logindata,),
    ProfilePage(data: logindata,),
    ProfilePage(data: logindata,)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.home, size: 20),
                Text('Home',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
              ]
          ),
          Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.paste, size: 20),
                Text('Order',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
              ]
          ),
          Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.add, size: 20),
                Text('New',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
              ]),
          Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.comment, size: 20),
                Text('Chat',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
              ]
          ),
          Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.perm_identity, size: 20),
                Text('Profil',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
              ]
          ),
        ],
        color: Colors.white,
        //buttonBackgroundColor: const Color(0xffF4EE42),
        buttonBackgroundColor: Colors.grey[100],
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: onItemTapped,
        letIndexChange: (index) => true,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}