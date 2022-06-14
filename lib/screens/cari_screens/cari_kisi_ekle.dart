import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CariKisiEkleMenu extends StatefulWidget {
  CariKisiEkleMenu({Key? key}) : super(key: key);

  @override
  CariKisiEklePage createState() => CariKisiEklePage();
}

final AdSoyad = TextEditingController();
final kisiMeslek = TextEditingController();
final SirketSahis = TextEditingController();

class CariKisiEklePage extends State<CariKisiEkleMenu> {
  CollectionReference yeniKisi =
      FirebaseFirestore.instance.collection("yeniKisi");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA7FFEB),
      appBar: AppBar(
        title: const Text("Hızlı Müşteri Ekle"),
      ),
      body: Center(
          child: Column(
        children: [
          const Image(
            image: AssetImage("assets/images/fast-customer.png"),
            width: 250,
            height: 150,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: AdSoyad,
              decoration: const InputDecoration(
                hintText: 'Ad Soyad',
                prefixIcon: Icon(Icons.vpn_key_outlined),
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white70,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: kisiMeslek,
              decoration: const InputDecoration(
                hintText: 'Meslek',
                prefixIcon: Icon(Icons.vpn_key_outlined),
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white70,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: SirketSahis,
              decoration: const InputDecoration(
                hintText: 'Şirket/Şahıs?',
                prefixIcon: Icon(Icons.vpn_key_outlined),
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white70,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: ElevatedButton.icon(
                  // <-- ElevatedButton
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                      primary: Colors.blueAccent),
                  onPressed: () async {
                    await yeniKisi.add({
                      'AdSoyad': AdSoyad.text,
                      'kisiMeslek': kisiMeslek.text,
                      'SirketSahis': SirketSahis.text,
                    });

                    var alert = AlertDialog(
                      title:
                          Icon(Icons.info, size: 50, color: Colors.blueAccent),
                      content: Text(
                        "${AdSoyad.text} isimli kişi eklenmiştir. ",
                        style: TextStyle(fontSize: 25),
                      ),
                    );

                    AdSoyad.clear();
                    kisiMeslek.clear();
                    SirketSahis.clear();

                    showDialog(
                        context: context,
                        builder: (BuildContext context) => alert);
                  },
                  icon: const Icon(
                    Icons.save,
                    size: 30.0,
                  ),
                  label: const Text("Kaydet"),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
