import 'dart:ffi';

import 'package:flutter/material.dart';

class filtreleme extends StatefulWidget {
  const filtreleme({super.key});

  @override
  State<filtreleme> createState() => _filtrelemeState();
}

class _filtrelemeState extends State<filtreleme> {
  String? secilenil = 'İl Seçiniz';
  String? secilenilce = 'İlçe Seçiniz';
  bool erkekSecili = false;
  bool kizSecili = false;
  bool ozelSecili = false;
  bool devletSecili = false;

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
                      "Yeni Yaşamınız,\nNerede Başlıyor?",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Color(0xff21254A),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: secilenil,
                        onChanged: (newValue) {
                          setState(() {
                            secilenil = newValue!;
                            secilenilce = 'İlçe Seçiniz'; // İlk Dropdown değiştiğinde ikinciyi sıfırla
                          });
                        },
                        items: ['İl Seçiniz', 'Seçenek 2', 'Seçenek 3', 'Seçenek 4']
                            .map((String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Color(0xff21254A),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: secilenilce,
                        onChanged: (newValue) {
                          setState(() {
                            secilenilce = newValue!;
                          });
                        },
                        items: secilenil == 'İl Seçiniz'
                            ? ['İlçe Seçiniz']
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ))
                                .toList()
                            : ['İlçe Seçiniz', 'Seçenek 2', 'Seçenek 3', 'Seçenek 4']
                                .map((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ))
                                .toList(),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                erkekSecili = true;
                                kizSecili = false;
                              });
                            },
                            child: Container(
                              width: 75,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: erkekSecili ? Colors.blue : Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center, // İcon ve metni dikey olarak ortalar
                                children: [
                                  Icon(
                                    Icons.man,
                                    color: erkekSecili ? Colors.white : Colors.blue,
                                    size: 32,
                                  ),
                                  SizedBox(height: 8), // Metin ile İcon arasında bir boşluk ekler
                                  Text(
                                    'Erkek', // İcon altındaki metin
                                    style: TextStyle(
                                      color: erkekSecili ? Colors.white : Colors.blue,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                kizSecili = true;
                                erkekSecili = false;
                              });
                            },
                            child: Container(
                              width: 75,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: kizSecili ? Colors.pink : Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center, // İkon ve metni dikey olarak ortalar
                                children: [
                                  Icon(
                                    Icons.woman_2,
                                    color: kizSecili ? Colors.white : Colors.pink,
                                    size: 32,
                                  ),
                                  SizedBox(height: 8), // Metin ile İkon arasında bir boşluk ekler
                                  Text(
                                    'Kız', // İkonun altındaki metin
                                    style: TextStyle(
                                      color: kizSecili ? Colors.white : Colors.pink,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Düğmeleri ortala
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ozelSecili = true;
                                    devletSecili = false;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: ozelSecili ? Colors.green : Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.business,
                                        color: ozelSecili ? Colors.white : Colors.green,
                                        size: 32,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Özel',
                                        style: TextStyle(
                                          color: ozelSecili ? Colors.white : Colors.green,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ozelSecili = false;
                                    devletSecili = true;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: devletSecili ? Colors.red : Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.account_balance,
                                        color: devletSecili ? Colors.white : Colors.red,
                                        size: 32,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Devlet',
                                        style: TextStyle(
                                          color: devletSecili ? Colors.white : Colors.red,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),],
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
