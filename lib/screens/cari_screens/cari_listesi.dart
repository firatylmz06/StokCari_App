import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CariGuncelle extends StatefulWidget {
  const CariGuncelle({Key? key}) : super(key: key);

  @override
  CariGuncelleState createState() => CariGuncelleState();
}

class CariGuncelleState extends State<CariGuncelle> {
  final TextEditingController AdSoyadController = TextEditingController();
  final TextEditingController kisiMeslekController = TextEditingController();

  final CollectionReference yenicaridb =
      FirebaseFirestore.instance.collection('yeniCariEkle');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      AdSoyadController.text = documentSnapshot['cariAdSoyad'];
      kisiMeslekController.text = documentSnapshot['cariTelefon'].toString();
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
                  "Hızlı Kullanıcı Ekle",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                TextField(
                  controller: AdSoyadController,
                  decoration: const InputDecoration(labelText: 'Ad Soyad'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: kisiMeslekController,
                  decoration: const InputDecoration(
                    labelText: 'Telefon Numarası',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = AdSoyadController.text;
                    final double? price =
                        double.tryParse(kisiMeslekController.text);
                    if (name != null && price != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await yenicaridb
                            .add({"cariAdSoyad": name, "cariTelefon": price});
                      }

                      if (action == 'update') {
                        await yenicaridb.doc(documentSnapshot!.id).update(
                            {"cariAdSoyad": name, "cariTelefon": price});
                      }

                      AdSoyadController.text = '';
                      kisiMeslekController.text = '';

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
        title: const Text('Cari Listesi'),
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
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Ad Soyad: " + documentSnapshot['cariAdSoyad']),
                    subtitle: Text("Telefon Numarası: " +
                        documentSnapshot['cariTelefon'].toString()),
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
