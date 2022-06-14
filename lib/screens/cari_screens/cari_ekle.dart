import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/cari_screens/cari_islem_menu.dart';

class YeniCariEkleMenu extends StatefulWidget {
  const YeniCariEkleMenu({Key? key}) : super(key: key);

  @override
  YeniCariPage createState() => YeniCariPage();
}

class YeniCariPage extends State<YeniCariEkleMenu> {
  final cariKategori = TextEditingController();
  final cariAdSoyad = TextEditingController();
  final cariTelefon = TextEditingController();
  final cariAdres = TextEditingController();
  final cariNot = TextEditingController();

  String dropdownValue = 'Şahıs';

  @override
  Widget build(BuildContext context) {
    CollectionReference yeniCariEkle = FirebaseFirestore.instance.collection("yeniCariEkle");
    return Scaffold(
      backgroundColor: Color(0xFFA7FFEB),
      appBar: AppBar(
        title: const Text("Yeni Cari Ekle"),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            height: 45,
            width: 390,
            child: DropdownButton<String>(
              value: dropdownValue,
              elevation: 30,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 3,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Şahıs', 'Şirket']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          buildContainer(cariKategori, "Kategori"),
          buildContainer(cariAdSoyad, "Ad Soyad"),
          buildContainer(cariTelefon, "Telefon", 10),
          buildContainer(cariAdres, "Adres"),
          buildContainer(cariNot, "Not", 20),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: ElevatedButton.icon(
              // <-- ElevatedButton
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50), primary: Colors.blueAccent),
              onPressed: () async {
                await yeniCariEkle.add({
                  'cariSahis': dropdownValue,
                  'cariKategori': cariKategori.text,
                  'cariAdSoyad': cariAdSoyad.text,
                  'cariTelefon': cariTelefon.text,
                  'cariAdres': cariAdres.text,
                  'cariNot': cariNot.text,
                });

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CariIslemMenu()));
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

  Container buildContainer(
      TextEditingController texteditcontrolbuild, String str,
      [int? max]) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autocorrect: true,
        maxLength: max,
        controller: texteditcontrolbuild,
        decoration: InputDecoration(
          hintText: str,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white70,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
      ),
    );
  }
}
