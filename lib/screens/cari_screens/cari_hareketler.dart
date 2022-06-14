import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class CariHareketlerMenu extends StatefulWidget {
  CariHareketlerMenu({Key? key}) : super(key: key);

  @override
  CariHareketPage createState() => CariHareketPage();
}

class CariHareketPage extends State<CariHareketlerMenu> {
  final TextEditingController cariAdSoyadController = TextEditingController();
  final TextEditingController cariHareketTuruController =
      TextEditingController();
  final TextEditingController cariHareketTipiController =
      TextEditingController();

  final CollectionReference yenicaridb =
      FirebaseFirestore.instance.collection('cariHareketGirisi');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';

    if (documentSnapshot != null) {
      action = 'update';
      cariAdSoyadController.text = documentSnapshot['cariAdSoyad'];
      cariHareketTuruController.text =
          documentSnapshot['cariHareketTuru'].toString();
      cariHareketTipiController.text =
          documentSnapshot['hareketTipi'].toString();
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
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? cariadsoyad = cariAdSoyadController.text;
                    final double? hareketturu =
                        double.tryParse(cariHareketTuruController.text);
                    final String? harekettipi = cariAdSoyadController.text;

                    if (cariadsoyad != null &&
                        hareketturu != null &&
                        harekettipi != null) {
                      if (action == 'create') {
                        await yenicaridb.add({
                          "cariAdSoyad": cariadsoyad,
                          "cariHareketTuru": hareketturu,
                          'hareketTipi': harekettipi
                        });
                      }

                      if (action == 'update') {
                        await yenicaridb.doc(documentSnapshot!.id).update({
                          "cariAdSoyad": cariadsoyad,
                          "cariHareketTuru": hareketturu
                        });
                      }

                      cariAdSoyadController.text = '';
                      cariHareketTuruController.text = '';
                      cariHareketTipiController.text = '';

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA7FFEB),
      appBar: AppBar(
        title: Text('Hareketler'),
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
                    title: Text("Ad Soyad: " +
                        documentSnapshot['cariAdSoyad'].toString()),
                    trailing: const SizedBox(
                      width: 100,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hareket Türü: " +
                            documentSnapshot['cariHareketTuru']),
                        Text(
                            "Hareket Tipi: " + documentSnapshot['hareketTipi']),
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
