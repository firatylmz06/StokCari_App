import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class DepoDurumMenusu extends StatefulWidget {
  DepoDurumMenusu({Key? key}) : super(key: key);

  @override
  DepoDurumPage createState() => DepoDurumPage();
}

class DepoDurumPage extends State<DepoDurumMenusu> {
  final TextEditingController yeniDepoKoduCont = TextEditingController();
  final TextEditingController yeniDepoSehirCont = TextEditingController();

  final CollectionReference yenicaridb =
      FirebaseFirestore.instance.collection('yeniDepo');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      yeniDepoKoduCont.text = documentSnapshot['yeniDepoKodu'];
      yeniDepoSehirCont.text = documentSnapshot['yeniDepoSehir'].toString();
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
                  "Hızlı Depo Ekle",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                TextField(
                  controller: yeniDepoKoduCont,
                  decoration: const InputDecoration(labelText: 'Ad Soyad'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: yeniDepoSehirCont,
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
                    final String? yeniDepoKodu = yeniDepoKoduCont.text;
                    final double? yeniDepoSehir =
                        double.tryParse(yeniDepoSehirCont.text);
                    if (yeniDepoKodu != null && yeniDepoSehir != null) {
                      if (action == 'create') {
                        await yenicaridb.add({
                          "yeniDepoKodu": yeniDepoKodu,
                          "yeniDepoSehir": yeniDepoSehir
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        await yenicaridb.doc(documentSnapshot!.id).update({
                          "yeniDepoKodu": yeniDepoKodu,
                          "yeniDepoSehir": yeniDepoSehir
                        });
                      }

                      // Clear the text fields
                      yeniDepoKoduCont.text = '';
                      yeniDepoSehirCont.text = '';

                      // Hide the bottom sheet
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
      appBar: AppBar(
        title: const Text('Depolar'),
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
                    title:
                        Text("Depo Kodu: " + documentSnapshot['yeniDepoKodu']),
                    subtitle: Text("Mal Sayısı: "),
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
