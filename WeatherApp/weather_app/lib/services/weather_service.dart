import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;


class WeatherService{
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(String cityName) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {

      // Get permission to access location
  LocationPermission locationPermission = await Geolocator.checkPermission();

  if (locationPermission == LocationPermission.denied) {
    // If permission is denied, request it from the user
    locationPermission = await Geolocator.requestPermission();
    if (locationPermission != LocationPermission.whileInUse &&
        locationPermission != LocationPermission.always) {
      
      return ""; // Or throw an error or handle as per your app's logic
    }
  }

  // Fetch the current location
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude, position.longitude);

  print(placemarks[0].toString());  

  // Convert the location to city name
  String cityName = placemarks.isNotEmpty ? placemarks[0].locality ?? "" : "";

  return cityName;
  }
 

//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

 // "592c17407c54a8a3aba35b571f2eb1e7"
}