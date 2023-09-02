import 'package:flutter/material.dart';

class filtreleme extends StatefulWidget {
  const filtreleme({super.key});

  @override
  State<filtreleme> createState() => _filtrelemeState();
}

class _filtrelemeState extends State<filtreleme> {


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
