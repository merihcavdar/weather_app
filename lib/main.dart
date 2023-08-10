import 'package:flutter/material.dart';
import 'data_service.dart';
import 'models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_response != null)
              Column(
                children: [
                  Image.network(_response!.iconUrl),
                  Text(
                    '${_response!.tempInfo.temperature} °C',
                    style: const TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                  Text(_response!.weatherInfo.description)
                ],
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50.0,
              ),
              child: SizedBox(
                width: 150.0,
                child: TextField(
                  controller: _cityTextController,
                  decoration: const InputDecoration(labelText: 'City'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _search();
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() {
      _response = response;
    });
  }
}
