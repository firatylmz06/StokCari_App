import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DepoKonumPage extends StatefulWidget {
  DepoKonumPage({Key? key}) : super(key: key);

  @override
  DepoKonum createState() => DepoKonum();
}

final yeniDepoKodu = TextEditingController();
final yeniDepoSehir = TextEditingController();

class DepoKonum extends State<DepoKonumPage> {
  CollectionReference yeniDepo =
      FirebaseFirestore.instance.collection("yeniDepo");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA7FFEB),
      appBar: AppBar(
        title: const Text("Depo Ekle"),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: yeniDepoKodu,
              autocorrect: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Depo Kodu',
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
              controller: yeniDepoSehir,
              maxLength: 6,
              decoration: const InputDecoration(
                hintText: 'Depo Şehir',
                prefixIcon: Icon(Icons.password),
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
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(5.0),
            child: ElevatedButton.icon(
              // <-- ElevatedButton
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50), primary: Colors.blueAccent),
              onPressed: () async {
                await yeniDepo.add({
                  'yeniDepoKodu': yeniDepoKodu.text,
                  'yeniDepoSehir': yeniDepoSehir.text,
                });

                yeniDepoKodu.clear();
                yeniDepoSehir.clear();

                var alert = AlertDialog(
                  title: Icon(Icons.info, size: 50, color: Colors.blueAccent),
                  content: Text(
                    "${yeniDepoSehir.text} şehrine \n${yeniDepoKodu.text} kodlu depo tanımlanmıştır.",
                    style: TextStyle(fontSize: 25),
                  ),
                );

                showDialog(
                    context: context, builder: (BuildContext context) => alert);
              },
              icon: const Icon(
                Icons.save,
                size: 30.0,
              ),
              label: const Text("Kaydet"),
            ),
          ),
        ],
      )),
    );
  }
}
