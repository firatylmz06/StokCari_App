import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/cari_screens/cari_islem_menu.dart';

class CariHareketGirisMenu extends StatefulWidget {
  const CariHareketGirisMenu({Key? key}) : super(key: key);

  @override
  CariHareketGirisPage createState() => CariHareketGirisPage();
}

class CariHareketGirisPage extends State<CariHareketGirisMenu> {
  final cariSahisSirket = TextEditingController();
  final cariHareketTuru = TextEditingController();
  final cariTutar = TextEditingController();
  final cariTarih = TextEditingController();
  final cariAciklama = TextEditingController();
  final cariAdSoyad = TextEditingController();
  final dovizMi = TextEditingController();

  String hareketBorc = "Borç";
  String hareketAlacak = "Alacak";

  static InputBorder greenAcc = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(color: Colors.greenAccent, width: 2),
  );

  static InputBorder redAcc = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(color: Colors.redAccent, width: 2),
  );

  static InputBorder secilen = greenAcc;
  static Color kaydetButon = Colors.greenAccent;

  @override
  Widget build(BuildContext context) {
    CollectionReference cariHareketGirisi =
        FirebaseFirestore.instance.collection("cariHareketGirisi");

    return Scaffold(
      backgroundColor: Color(0xFFE0F2F1),
      appBar: AppBar(
        title: const Text("Hareket Girişi"),
      ),
      body: Center(
          child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: ElevatedButton.icon(
                // <-- ElevatedButton
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(180, 40),
                    primary: Colors.greenAccent),
                onPressed: () {
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Alacak girişi seçildi.')));
                    secilen = greenAcc;
                    kaydetButon = Colors.greenAccent;
                  });
                },
                icon: const Icon(
                  Icons.money,
                  size: 30.0,
                ),
                label: const Text("Alacak"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: ElevatedButton.icon(
                // <-- ElevatedButton
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(180, 40), primary: Colors.redAccent),
                onPressed: () {
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Borç girişi seçildi.')));
                    secilen = redAcc;
                    kaydetButon = Colors.redAccent;
                  });
                },

                icon: const Icon(
                  Icons.takeout_dining,
                  size: 20.0,
                ),
                label: const Text("Borç"),
              ),
            ),
          ]),
          buildContainer(cariAdSoyad, "Ad-Soyad"),
          buildContainer(cariSahisSirket, "Şahıs/Şirket"),
          buildContainer(cariHareketTuru, "Hareket Türü|Evrak|Pos"),
          buildContainer(cariTutar, "Tutar"),
          buildContainer(dovizMi, "TL/USD/EUR"),
          buildContainer(cariTarih, "Tarih"),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50), primary: kaydetButon),
              onPressed: () async {
                if (secilen == redAcc) {
                  await cariHareketGirisi.add({
                    'cariAdSoyad': cariAdSoyad.text,
                    'cariSahisSirket': cariSahisSirket.text,
                    'cariHareketTuru': cariHareketTuru.text,
                    'cariTutar': cariTutar.text,
                    'dovizMi': dovizMi.text,
                    'cariTarih': cariTarih.text,
                    'hareketTipi': hareketBorc.toString(),
                  });
                } else if (secilen == greenAcc) {
                  await cariHareketGirisi.add({
                    'cariAdSoyad': cariAdSoyad.text,
                    'cariSahisSirket': cariSahisSirket.text,
                    'cariHareketTuru': cariHareketTuru.text,
                    'cariTutar': cariTutar.text,
                    'dovizMi': dovizMi.text,
                    'cariTarih': cariTarih.text,
                    'hareketTipi': hareketAlacak,
                  });
                } else {
                  print("hata");
                }

                cariAdSoyad.clear();
                cariSahisSirket.clear();
                cariHareketTuru.clear();
                cariTutar.clear();
                dovizMi.clear();
                cariTarih.clear();

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
      TextEditingController txtcontroller, String btnyazisi,
      [int? max]) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        autocorrect: true,
        maxLength: max,
        controller: txtcontroller,
        decoration: InputDecoration(
          hintText: btnyazisi,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white70,
          enabledBorder: secilen,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
      ),
    );
  }
}
