import 'package:flutter/material.dart';

void main() {
  runApp(FiltreleApp());
}

class FiltreleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filtrele App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedCity; // Başlangıçta null olarak ayarlandı
  String? selectedDistrict; // Başlangıçta null olarak ayarlandı
  String selectedGender = 'Erkek';
  String selectedType = 'KYK';

  List<String> cities = ['İstanbul', 'Ankara', 'İzmir', 'Bursa'];
  List<String> districts = ['Kadıköy', 'Çankaya', 'Bornova', 'Osmangazi'];
  List<String> genders = ['Erkek', 'Kız'];
  List<String> types = ['KYK', 'Özel'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrele App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedCity,
              onChanged: (newValue) {
                setState(() {
                  selectedCity = newValue;
                  selectedDistrict = null; // Şehir değiştikçe ilçeyi sıfırla
                });
              },
              items: cities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            if (selectedCity != null) // Şehir seçilmişse ilçe dropdown'u göster
              DropdownButton<String>(
                value: selectedDistrict,
                onChanged: (newValue) {
                  setState(() {
                    selectedDistrict = newValue;
                  });
                },
                items: districts.map((district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

