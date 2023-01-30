import 'package:client/ui/component/component.dart';
import 'package:client/ui/dashboard.dart';
import 'package:client/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../conf.dart';

//import 'package:client/views/default.dart';
//import 'package:client/views/tambah_alamat.dart';

class EditProfilePage extends StatelessWidget {
  SharedPreferences data;

  EditProfilePage({Key? key, required this.data}) : super(key: key);

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
        padding: EdgeInsets.only(top: 20.0, left: 19.0, right: 19.0),
        child: Column(children: <Widget>[
          titleHeader2(titPROFILEPENGGUNA, context),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Email terdaftar',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff515252)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          const TextField(
            enabled: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xffE5E5E5),
                labelText: 'rendybustari@gmail.com',
                hintText: 'Masukan password anda'),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Perbaharui / Ubah Password',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff515252)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          const TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Masukan password anda'),
          ),
          SizedBox(
            height: 15,
          ),
          const TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Konfirmasi Password',
                hintText: 'Masukan konfirmasi password anda'),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Perbaharui / Ubah PIN',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff515252)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          const TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '6 Digit PIN',
                hintText: 'Masukan 6 Digit PIN anda'),
          ),
          SizedBox(
            height: 15,
          ),
          const TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Konfirmasi 6 Digit PIN',
                hintText: 'Masukan konfirmasi 6 Digit PIN anda'),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Nama lengkap',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff515252)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          const TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama lengkap sesuai e-KTP',
                hintText: 'Masukan Nama lengkap sesuai e-KTP anda'),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 15,
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(20),
                      child: ListTile(
                        leading: SvgPicture.string(
                            '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M12 2c5.523 0 10 4.477 10 10s-4.477 10-10 10S2 17.523 2 12S6.477 2 12 2Zm0 1.5a8.5 8.5 0 1 0 0 17a8.5 8.5 0 0 0 0-17ZM12 7a.75.75 0 0 1 .75.75v3.5h3.5a.75.75 0 0 1 0 1.5h-3.5v3.5a.75.75 0 0 1-1.5 0v-3.5h-3.5a.75.75 0 0 1 0-1.5h3.5v-3.5A.75.75 0 0 1 12 7Z"/></svg>',
                            color: Colors.red,
                            width: 40,
                            height: 40),
                        title: Text('Tambah Alamat',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF26A4A))),
                        selected: true,
                        onTap: () {
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TambahAlamat()),
                          //);
                        },
                      ),
                    ),
                    flex: 8,
                  ),
                ],
              ),
            ),
            elevation: 0.0,
            margin: EdgeInsets.all(5),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffF4EE42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                  child: Text(
                    "Simpan Data Profil",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff515252)),
                  ),
                  onPressed: () {}))
        ]),
      ),
    ))));
  }
}
