import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('377c870f1723e0eb6aad5fdd4a057628');
  Weather? _weather;

  _fetcWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/cloud (1).json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud (3).json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/cloud (2).json';
      case 'thunderstorm':
        return 'assets/cloud (4).json';
      case 'clear':
        return 'assets/cloud (1).json';
      default:
        return 'assets/cloud (1).json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetcWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade700,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _weather?.cityName ?? 'Loading city...',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              Text(
                '${_weather?.temperature.round()}°C...',
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(_weather?.mainCondition ?? ''),
            ],
          ),
        ));
  }
}
