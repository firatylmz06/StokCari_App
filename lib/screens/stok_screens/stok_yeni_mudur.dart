import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class YeniMudurMenusu extends StatefulWidget {
  const YeniMudurMenusu({Key? key}) : super(key: key);

  @override
  YeniMudurPage createState() => YeniMudurPage();
}

final yeniMudurKodu = TextEditingController();
final yeniMudurTelefon = TextEditingController();
final yeniMudurGizliCevap = TextEditingController();
final yeniMudurSifre = TextEditingController();

class YeniMudurPage extends State<YeniMudurMenusu> {
  CollectionReference yeniMudurDB =
      FirebaseFirestore.instance.collection("Person");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA7FFEB),
      appBar: AppBar(
        title: const Text("Yeni Müdür Tanımla"),
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
              controller: yeniMudurKodu,
              autocorrect: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Sorumlu Müdür',
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
              controller: yeniMudurGizliCevap,
              maxLength: 6,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Gizli Cevap',
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
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: yeniMudurSifre,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Müdür Şifresi',
                prefixIcon: Icon(Icons.wrap_text),
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
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: yeniMudurTelefon,
              autocorrect: true,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Telefon Numaranız',
                prefixIcon: Icon(Icons.phone),
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
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50), primary: Colors.blueAccent),
              onPressed: () async {
                await yeniMudurDB.add({
                  'yeniMudur': yeniMudurKodu.text,
                  'yeniMudurTelefon': yeniMudurTelefon.text,
                  'yeniMudurGizliCevap': yeniMudurGizliCevap.text,
                  'yeniMudurSifre': yeniMudurSifre.text,
                });

                var alert = AlertDialog(
                  title: Icon(Icons.info, size: 50, color: Colors.blueAccent),
                  content: Text(
                    "${yeniMudurKodu.text} kodlu \n${yeniMudurTelefon.text} numaralı müdür ataması yapılmıştır. ",
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
