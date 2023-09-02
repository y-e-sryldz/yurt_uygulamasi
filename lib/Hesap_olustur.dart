import 'package:flutter/material.dart';
import 'package:yurt_uygulamasi/main.dart';

class Hesap_olustur extends StatefulWidget {
  const Hesap_olustur({super.key});

  @override
  State<Hesap_olustur> createState() => _Hesap_olusturState();
}

class _Hesap_olusturState extends State<Hesap_olustur> {
  String username = "";
  String password = "";
  bool BosAlanUyarisiIsim = false; // Boş alan uyarısını gösterme durumu
  bool BosAlanUyarisiSifre = false; // Boş alan uyarısını gösterme durumu
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff21254A),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * .25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("resimler/baslik.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Merhaba,\nHoşgeldiniz",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Kullanıcı Adı",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                      ),
                      style: TextStyle(
                          color: Colors.white), // Yazı rengini beyaz yapar
                      onChanged: (value) {
                        setState(() {
                          username = value;
                          BosAlanUyarisiIsim = false;
                        });
                      },
                    ),
                    if (BosAlanUyarisiIsim) // Boş alan uyarısı gösteriliyor mu?
                      Text(
                        "Lütfen bütün boşlukları doldurunuz.",
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Şifre",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                      ),
                      style: TextStyle(
                          color: Colors.white), // Yazı rengini beyaz yapar
                      onChanged: (value) {
                        setState(() {
                          password = value;
                          BosAlanUyarisiSifre = false;
                        });
                      },
                    ),
                    if (BosAlanUyarisiSifre) // Boş alan uyarısı gösteriliyor mu?
                      Text(
                        "Lütfen bütün boşlukları doldurunuz.",
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          if (username.isEmpty || password.isEmpty) {
                            if (username.isEmpty && password.isEmpty) {
                              // Kullanıcı adı ve şifre boşsa, uyarıyı göster.
                              setState(() {
                                BosAlanUyarisiIsim = true;
                                BosAlanUyarisiSifre = true;
                              });
                            } else if (username.isEmpty) {
                              setState(() {
                                BosAlanUyarisiIsim = true;
                              });
                            } else if (password.isEmpty) {
                              setState(() {
                                BosAlanUyarisiSifre = true;
                              });
                            }
                          }else {

                            //kayıt olundu işlemleri yapılcak
                           
                          }
                        },
                        child: Text(
                          "Hesap Oluştur",
                          style: TextStyle(color: Colors.pink[200]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Geri Dön",
                          style: TextStyle(color: Colors.pink[200]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
