import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Hesap_olustur extends StatefulWidget {
  const Hesap_olustur({super.key});

  @override
  State<Hesap_olustur> createState() => _Hesap_olusturState();
}

class _Hesap_olusturState extends State<Hesap_olustur> {
  BannerAd? _bannerAdTop; // Üstteki reklam
  BannerAd? _bannerAdBottom; // Altta olan reklam
  InterstitialAd? _interstitialAd;

  final adUnitIdTop = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  final adUnitIdBottom = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735717';

  @override
  void initState() {
    super.initState();
    _loadAds();
  } 
  
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
                        hintText: "E-posta Adresi",
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
                    SizedBox(
                height: 30,
              ),
              // Üstteki reklamı ortalamak için Expanded widget kullanıyoruz
              Align(
                alignment: Alignment.topCenter,
                child: _bannerAdTop != null
                    ? SizedBox(
                        width: _bannerAdTop!.size.width.toDouble(),
                        height: _bannerAdTop!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAdTop!),
                      )
                    : Container(), // Reklam yüklenmemişse boş bir Container
              ),
              // Altta olan reklamı ortalamak için Expanded widget kullanıyoruz
              Align(
                alignment: Alignment.bottomCenter,
                child: _bannerAdBottom != null
                    ? SizedBox(
                        width: _bannerAdBottom!.size.width.toDouble(),
                        height: _bannerAdBottom!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAdBottom!),
                      )
                    : Container(), // Reklam yüklenmemişse boş bir Container
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
  void _loadAds() async {
    _bannerAdTop = BannerAd(
      adUnitId: adUnitIdTop,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAdTop = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    )..load();

    _bannerAdBottom = BannerAd(
      adUnitId: adUnitIdBottom,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAdBottom = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    )..load();
  }

  

  @override
  void dispose() {
    _bannerAdTop?.dispose();
    _bannerAdBottom?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }
}
