import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/stok_cari_secim.dart';
import 'package:rive/rive.dart';

final email = TextEditingController();
final yeniSifre = TextEditingController();

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

AuthService _authService = AuthService();

class LoginPageFirst extends StatefulWidget {
  LoginPageFirst({Key? key}) : super(key: key);

  @override
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<LoginPageFirst> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  CollectionReference yeniMudurDB =
      FirebaseFirestore.instance.collection("yeniMudurDB");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      color: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                children: const [
                  SizedBox(
                    child: RiveAnimation.asset('assets/images/firat.riv'),
                    height: 180,
                    width: 140,
                  ),
                  Text("CARISTOK",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
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
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: _emailController,
                                  autocorrect: true,
                                  maxLength: 45,
                                  decoration: const InputDecoration(
                                    hintText: 'Sorumlu Kodu',
                                    prefixIcon: Icon(Icons.vpn_key),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Şifre',
                                    suffix: InkWell(
                                      child: Icon(Icons.visibility),
                                    ),
                                    prefixIcon: Icon(Icons.password),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () {
                            _authService
                                .signIn(_emailController.text,
                                    _passwordController.text)
                                .then((value) {
                              return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CariStokMenu()));
                            });
                            _emailController.clear();
                            _passwordController.clear();
                          },

                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(30)),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                  child: Text(
                                "Giriş yap",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 25,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: ElevatedButton(
                            child: const Text('Üye Ol'),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 400,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          buildContainer(
                                              _emailController, "E-Mail"),
                                          buildContainer(_passwordController,
                                              "Yeni Şifre"),
                                          InkWell(
                                            onTap: () {
                                              _authService
                                                  .createPerson(
                                                      _emailController.text,
                                                      _passwordController.text)
                                                  .then((value) {
                                                return Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CariStokMenu()));
                                              });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blueAccent,
                                                      width: 2),
                                                  //color: colorPrimaryShade,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(30))),
                                              child: const Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Center(
                                                    child: Text(
                                                  "Kayıt Ol",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            var alert = const AlertDialog(
                              title: Icon(Icons.warning,
                                  size: 50, color: Colors.redAccent),
                              content: Text(
                                "Bu uygulama Fırat YILMAZ tarafından Starbucks'ta Filtre Kahve eşliğinde günde 6 saat çalışarak 15 günde yazılmıştır.\n\nBu uygulamayı kullanmaya başlayan herkes Ahmet Cevahir ÇINAR'ın  şartları ve koşulları kabul etmiş sayılır.",
                                style: TextStyle(fontSize: 25),
                              ),
                            );

                            showDialog(
                                context: context,
                                builder: (BuildContext context) => alert);
                          },
                          child: const Text(
                              "Kayıt olarak, Şartlar ve Koşulları ve Gizlilik Polikasını kabul etmiş olursunuz.",
                              textAlign: TextAlign.center),
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

  Container buildContainer(TextEditingController aa, String str, [int? max]) {
    return Container(
        width: 410,
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLength: max,
          controller: aa,
          autocorrect: true,
          decoration: InputDecoration(hintText: str),
        ));
  }
}
