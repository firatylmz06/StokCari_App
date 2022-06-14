import 'package:flutter/material.dart';
import 'package:flutter_project/screens/cari_screens/cari_ekle.dart';
import 'package:flutter_project/screens/cari_screens/cari_listesi.dart';
import 'package:flutter_project/screens/cari_screens/cari_kisi_ekle.dart';

import '../stok_cari_secim.dart';
import 'cari_hareket_girisi.dart';
import 'cari_hareketler.dart';

class CariIslemMenu extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xFFA7FFEB),
          appBar: AppBar(
            title: Text('Cari İşlemleri'),
          ),
          body: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Image(
                image: AssetImage("assets/images/cari.png"),
                width: 250,
                height: 150,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: ElevatedButton.icon(
                        // <-- ElevatedButton
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(180, 75),
                            primary: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const YeniCariEkleMenu()));
                        },
                        icon: const Icon(
                          Icons.fiber_new_rounded,
                          size: 30.0,
                        ),
                        label: const Text("Cari Ekle"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: ElevatedButton.icon(
                        // <-- ElevatedButton
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(180, 75),
                            primary: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CariHareketGirisMenu()));
                        },
                        icon: const Icon(
                          Icons.move_down,
                          size: 30.0,
                        ),
                        label: const Text("Hareket Girişi"),
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 15,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: ElevatedButton.icon(
                        // <-- ElevatedButton
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(180, 75),
                            primary: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CariKisiEkleMenu()));
                        },
                        icon: const Icon(
                          Icons.person_add,
                          size: 30.0,
                        ),
                        label: const Text("Hızlı Müşteri Ekle"),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: ElevatedButton.icon(
                        // <-- ElevatedButton
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(180, 75),
                            primary: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CariHareketlerMenu()));
                        },
                        icon: const Icon(
                          Icons.password,
                          size: 30.0,
                        ),
                        label: const Text("Hareketler"),
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 15,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: ElevatedButton.icon(
                        // <-- ElevatedButton
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(180, 75),
                            primary: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CariGuncelle()));
                        },
                        icon: const Icon(
                          Icons.person,
                          size: 30.0,
                        ),
                        label: const Text("Cari Listesi"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: ElevatedButton.icon(
                        // <-- ElevatedButton
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(180, 75),
                            primary: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CariStokMenu()));
                        },
                        icon: const Icon(
                          Icons.group,
                          size: 30.0,
                        ),
                        label: const Text("Ana Menü"),
                      ),
                    ),
                  ]),
            ],
          ))),
    );
  }
}
