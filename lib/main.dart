import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yurt_uygulamasi/filtreleme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Yurt uygulamasi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd? _bannerAdTop; // Üstteki reklam
  BannerAd? _bannerAdBottom; // Altta olan reklam
  InterstitialAd? _interstitialAd;

  final adUnitIdTop = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  final adUnitIdBottom = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735717';

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  @override
  void initState() {
    super.initState();
    _loadAds();
    _loadAd(context);
  }

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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Şifremi Unuttum",
                              style: TextStyle(color: Colors.pink[200]),
                            ))),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                          onPressed: () {
                           
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Giriş Yap",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                          ),
                          TextButton(
                          onPressed: () {},
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Hesap Oluştur",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                          ),
                        ],
                      ),
                      SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                               _interstitialAd?.show();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => filtreleme()),
                            );
                          },
                          child: Text(
                            "Hesap Oluşturmadan Devam Et",
                            style: TextStyle(color: Colors.pink[200]),
                          )
                        )
                      ),
                  ],
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

  void _loadAd(BuildContext context) async {
    InterstitialAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                onAdClicked: (ad) {});
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  void dispose() {
    _bannerAdTop?.dispose();
    _bannerAdBottom?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }
}
