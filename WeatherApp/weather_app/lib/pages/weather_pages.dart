import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //apikey
  final _weatherService =
      WeatherService(apiKey: '592c17407c54a8a3aba35b571f2eb1e7');

  //weather object
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();
    //get the weathe for this city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sun.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/cloudsun.json';
      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/sun.json';
    }
  }

  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Column(
                children: [
                  const Icon(Icons.location_on, size: 30,),
                   Text(_weather?.cityName ?? "loading city name...", style: TextStyle(fontSize: 30),),
                ],
              ),
            ),
           
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text(
              '${_weather?.temperature.toString()}°' ??
                  "loading temperature...",
              style: const TextStyle(fontSize: 50),
            ),
           
          ],
        ),
      ),
    );
  }
}
