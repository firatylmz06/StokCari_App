import 'package:flutter/material.dart';
import 'package:flutter_project/screens/stok_screens/stok_islem_menu.dart';

import '../login_page.dart';
import 'cari_screens/cari_islem_menu.dart';

class CariStokMenu extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Ana Menü', textAlign: TextAlign.center),
          ),
          body: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 60,
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
                            fixedSize: const Size(150, 50),
                            primary: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StokIslemMenusu()));
                        },
                        icon: const Icon(
                          Icons.saved_search,
                          size: 30.0,
                        ),
                        label: const Text("STOK"),
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
                            fixedSize: const Size(150, 50),
                            primary: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CariIslemMenu()));
                        },
                        icon: const Icon(
                          Icons.analytics,
                          size: 30.0,
                        ),
                        label: const Text("CARİ"),
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: ElevatedButton.icon(
                  // <-- ElevatedButton
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 60),
                      primary: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPageFirst()));
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    size: 30.0,
                  ),
                  label: const Text("Çıkış"),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ))),
    );
  }
}
