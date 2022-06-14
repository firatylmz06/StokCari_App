import 'package:flutter/material.dart';
import 'package:flutter_project/screens/stok_screens/stok_yeni_mudur.dart';

import 'stok_yeni_depo.dart';

class AyarlarMenusu extends StatefulWidget {
  AyarlarMenusu({Key? key}) : super(key: key);

  @override
  AyarlarPage createState() => AyarlarPage();
}

class AyarlarPage extends State<AyarlarMenusu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA7FFEB),
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Image(
            image: AssetImage("assets/images/ayarlar.png"),
            width: 250,
            height: 150,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50), primary: Colors.blueAccent),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => YeniMudurMenusu()));
              },
              icon: const Icon(
                Icons.account_box,
                size: 30.0,
              ),
              label: const Text("Yeni Müdür Tanımla"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50), primary: Colors.blueAccent),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DepoKonumPage()));
              },
              icon: const Icon(
                Icons.store,
                size: 30.0,
              ),
              label: const Text("Depo Ekle"),
            ),
          ),
        ],
      )),
    );
  }
}
