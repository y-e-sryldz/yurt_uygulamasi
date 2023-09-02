import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yurt_uygulamasi/Hesap_olustur.dart';
import 'package:yurt_uygulamasi/filtreleme.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  String username = "";
  String password = "";
  bool BosAlanUyarisiIsim = false; // Boş alan uyarısını gösterme durumu
  bool BosAlanUyarisiSifre = false; // Boş alan uyarısını gösterme durumu

  //anonim kullanıcı fonksiyonu
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      if (user != null) {
        print('Anonim kullanıcı giriş yaptı: ${user.uid}');
      }
    } catch (e) {
      print('Anonim kullanıcı girişi başarısız oldu: $e');
    }
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
                      obscureText:
                          true, // Şifreyi noktalı karakterlerle göstermek için
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
                            onPressed: () async {
                              try {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                  email: username,
                                );
                                // Şifre sıfırlama bağlantısı başarıyla gönderildi.
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Başarılı'),
                                      content: Text(
                                          'Şifre sıfırlama bağlantısı e-posta adresinize gönderildi.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Tamam'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } catch (e) {
                                setState(() {
                                  BosAlanUyarisiIsim = true;
                                });
                                // Hata durumunda burada işlemler yapabilirsiniz.
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Hata'),
                                      content: Text(
                                          'Şifre sıfırlama işlemi başarısız oldu: $e'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Tamam'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text(
                              "Şifremi Unuttum",
                              style: TextStyle(color: Colors.pink[200]),
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              if (username.isEmpty && password.isEmpty) {
                                // Kullanıcı adı veya şifre boşsa, uyarıyı göster.
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
                              } else {
                                Signin(username, password);
                              }
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
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Hesap_olustur()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                "Hesap Oluştur",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: TextButton(
                            onPressed: () {
                              signInAnonymously();
                              _interstitialAd?.show();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => filtreleme()),
                              );
                            },
                            child: Text(
                              "Misafir Girişi",
                              style: TextStyle(color: Colors.pink[200]),
                            ))),
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

  Future<String?> Signin(String username, String password) async {
    String? res;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => filtreleme()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "Kullanıcı Bulunamadı";
      } else if (e.code == "wrong-password") {
        res = "Sifre Yanlış";
      } else if (e.code == "user-disabled") {
        res = "Kullanıcı Pasif";
      }
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Hata"),
              content: Text(res!),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Geri Don"))
              ],
            );
          });
    }
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

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => filtreleme()),
      );
    } catch (e) {
      print("Giriş başarısız: $e");
    }
  }
}
