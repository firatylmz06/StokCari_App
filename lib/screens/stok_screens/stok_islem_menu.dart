import 'package:flutter/material.dart';
import 'package:flutter_project/screens/stok_screens/stok_karti_page.dart';
import 'package:flutter_project/screens/stok_screens/stok_sil_guncelle.dart';
import '../stok_cari_secim.dart';
import 'stok_ayarlar.dart';
import 'stok_depolar.dart';

class StokIslemMenusu extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xFFA7FFEB),
          appBar: AppBar(
            title: Text('Stok İşlemleri'),
          ),
          body: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Image(
                image: AssetImage("assets/images/islemler.png"),
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
                            fixedSize: const Size(150, 75),
                            primary: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StokKartiMenu()));
                        },
                        icon: const Icon(
                          Icons.saved_search,
                          size: 30.0,
                        ),
                        label: const Text("STOK KARTI"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 75),
                            primary: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UrunListeMenu()));
                        },
                        icon: const Icon(
                          Icons.list,
                          size: 30.0,
                        ),
                        label: const Text("Ürün Listesi"),
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 75),
                          primary: Colors.blueAccent),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DepoDurumMenusu()));
                      },
                      icon: const Icon(
                        Icons.store,
                        size: 30.0,
                      ),
                      label: const Text("Depolar"),
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
                          fixedSize: const Size(150, 75),
                          primary: Colors.blueAccent),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AyarlarMenusu()));
                      },
                      icon: const Icon(
                        Icons.password,
                        size: 30.0,
                      ),
                      label: const Text("Ayarlar"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton.icon(
                    // <-- ElevatedButton
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 75),
                        primary: Colors.blueAccent),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CariStokMenu()));
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
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
