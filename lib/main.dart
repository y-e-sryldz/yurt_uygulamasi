import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
      debugShowCheckedModeBanner: false,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banner Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Banner Example'),
        ),
        body: Column(
          children: [
            // Üstteki reklamı ortalamak için Expanded widget kullanıyoruz
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: _bannerAdTop != null
                    ? SizedBox(
                        width: _bannerAdTop!.size.width.toDouble(),
                        height: _bannerAdTop!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAdTop!),
                      )
                    : Container(), // Reklam yüklenmemişse boş bir Container
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Bas butonuna tıklanınca yapılacak işlemler
              },
              child: Text("bas"),
            ),
            // Altta olan reklamı ortalamak için Expanded widget kullanıyoruz
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _bannerAdBottom != null
                    ? SizedBox(
                        width: _bannerAdBottom!.size.width.toDouble(),
                        height: _bannerAdBottom!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAdBottom!),
                      )
                    : Container(), // Reklam yüklenmemişse boş bir Container
              ),
            ),
          ],
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
    super.dispose();
  }
}
