import 'package:flutter/material.dart';
import 'package:flutter_project/screens/stok_screens/stok_yeni_kart.dart';
import 'package:flutter_project/screens/stok_screens/stok_sil_guncelle.dart';

class StokKartiMenu extends StatefulWidget {
  StokKartiMenu({Key? key}) : super(key: key);

  @override
  StokKartiPage createState() => StokKartiPage();
}

class StokKartiPage extends State<StokKartiMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFA7FFEB),
        appBar: AppBar(
          title: const Text("Stok Kartı İşlemleri"),
        ),
        body: Center(
            child: Column(children: <Widget>[
          const SizedBox(
            height: 200,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: ElevatedButton.icon(
              // <-- ElevatedButton
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 100), primary: Colors.blueAccent),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => YeniStokKartMen()));
              },
              icon: const Icon(
                Icons.credit_card,
                size: 30.0,
              ),
              label: const Text("YENİ KAYIT"),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: ElevatedButton.icon(
              // <-- ElevatedButton
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 100), primary: Colors.blueAccent),

              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UrunListeMenu()));
              },
              icon: const Icon(
                Icons.list,
                size: 30.0,
              ),
              label: const Text("SİL - GÜNCELLE"),
            ),
          ),
        ])));
  }
}
