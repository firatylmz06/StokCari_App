import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UrunListeMenu extends StatefulWidget {
  const UrunListeMenu({Key? key}) : super(key: key);

  @override
  UrunListePage createState() => UrunListePage();
}

class UrunListePage extends State<UrunListeMenu> {
  final TextEditingController urunBarkodCont = TextEditingController();
  final TextEditingController urunAdCont = TextEditingController();
  final TextEditingController stokKoduCont = TextEditingController();
  final TextEditingController stokDepoContr = TextEditingController();
  final TextEditingController stokDepoCont = TextEditingController();
  final TextEditingController sorumluMudurCont = TextEditingController();
  final TextEditingController satisFiyatContr = TextEditingController();
  final TextEditingController kayitTarihiCont = TextEditingController();
  final TextEditingController alisFiyatCont = TextEditingController();

  final CollectionReference yenicaridb =
      FirebaseFirestore.instance.collection('yeniStokKarti');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      urunAdCont.text = documentSnapshot['urunAd'];
      urunBarkodCont.text = documentSnapshot['urunBarkod'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hızlı Stok Düzenle",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                TextField(
                  controller: urunBarkodCont,
                  decoration: const InputDecoration(labelText: 'Barkod'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: urunAdCont,
                  decoration: const InputDecoration(
                    labelText: 'Stok Adı',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = urunAdCont.text;
                    final double? price = double.tryParse(urunBarkodCont.text);
                    if (name != null && price != null) {
                      if (action == 'create') {
                        await yenicaridb
                            .add({"cariAdSoyad": name, "cariTelefon": price});
                      }

                      if (action == 'update') {
                        await yenicaridb.doc(documentSnapshot!.id).update(
                            {"cariAdSoyad": name, "cariTelefon": price});
                      }

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> silCari(String productId) async {
    await yenicaridb.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kullanıcı Başarıyla Silindi')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA7FFEB),
      appBar: AppBar(
        title: const Text('Stok Listesi'),
      ),
      body: StreamBuilder(
        stream: yenicaridb.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    title: Text(
                        "ÜrünAd: " + documentSnapshot['urunAd'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => silCari(documentSnapshot.id)),
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Barkod: " + documentSnapshot['urunBarkod']),
                        Text("Stok Kodu: " + documentSnapshot['stokKodu']),
                        Text("Depo: " + documentSnapshot['stokDepo']),
                        Text("Sorumlu: " + documentSnapshot['sorumluMudur']),
                        Text("Satış Fiyat: " + documentSnapshot['satisFiyat']),
                        Text("Alış Fiyat: " + documentSnapshot['alisFiyat']),
                        Text(
                            "Kayıt Tarihi: " + documentSnapshot['kayitTarihi']),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
