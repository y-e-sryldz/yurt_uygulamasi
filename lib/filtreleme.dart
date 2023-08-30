import 'package:flutter/material.dart';

class filtreleme extends StatefulWidget {
  const filtreleme({super.key});

  @override
  State<filtreleme> createState() => _filtrelemeState();
}

class _filtrelemeState extends State<filtreleme> {
 
  String? selectedCity; // Başlangıçta null olarak ayarlandı

  List<String> cities = ['İstanbul', 'Ankara', 'İzmir', 'Bursa'];

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
                });
              },
              items: cities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
