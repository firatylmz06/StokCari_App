import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/screens/stok_screens/stok_karti_page.dart';

final TextEditingController stokKodu = TextEditingController();
final TextEditingController urunAd = TextEditingController();
final TextEditingController urunBarkod = TextEditingController();
final TextEditingController alisFiyat = TextEditingController();
final TextEditingController satisFiyat = TextEditingController();
final TextEditingController sorumluMudur = TextEditingController();
final TextEditingController kayitTarihi = TextEditingController();
final TextEditingController stokDepo = TextEditingController();

class YeniStokKartMen extends StatefulWidget {
  const YeniStokKartMen({Key? key}) : super(key: key);

  @override
  YeniStokKarti createState() => YeniStokKarti();
}

class YeniStokKarti extends State<YeniStokKartMen> {

  CollectionReference yeniStokKarti =
      FirebaseFirestore.instance.collection("yeniStokKarti");

  String dropdownValue = 'D001';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFA7FFEB),
        appBar: AppBar(
          title: const Text('Yeni Stok Kartı'),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(50, 80, 30, 5),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Column(
                            children: [
                              buildContainer(stokKodu, "Stok Kodu", 20),
                              buildContainer(urunAd, "Ürün Adı"),
                              buildContainer(urunBarkod, "Barkod", 13),
                              buildContainer(alisFiyat, "Alış Fiyat"),
                              buildContainer(
                                satisFiyat,
                                "Satış Fiyat",
                              ),
                              buildContainer(sorumluMudur, "Sorumlu Müdür", 6),

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
                                  items: <String>['D001', 'D002']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),

                              buildContainer(kayitTarihi, "Kayıt Tarihi"),
                              Container(
                                  margin: const EdgeInsets.only(),
                                  child: ElevatedButton(
                                    child: Text('Kaydet'),
                                    onPressed: () async {
                                      await yeniStokKarti.add({
                                        'stokKodu': stokKodu.text,
                                        'urunAd': urunAd.text,
                                        'urunBarkod': urunBarkod.text,
                                        'alisFiyat': alisFiyat.text,
                                        'satisFiyat': satisFiyat.text,
                                        'sorumluMudur': sorumluMudur.text,
                                        'stokDepo': dropdownValue,
                                        'kayitTarihi': kayitTarihi.text,
                                      });

                                      stokKodu.clear();
                                      urunAd.clear();
                                      urunBarkod.clear();
                                      alisFiyat.clear();
                                      satisFiyat.clear();
                                      sorumluMudur.clear();
                                      stokDepo.clear();
                                      kayitTarihi.clear();

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StokKartiMenu()));
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ));
  }

  Container buildContainer(TextEditingController txt,  String str, [int? max]) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: TextField(

        maxLength: max,
        controller: txt,
        decoration: InputDecoration(hintText: str, border: InputBorder.none),
      ),
    );
  }
}
