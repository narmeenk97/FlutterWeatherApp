//this widget displays the primary weather container
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/weather_response.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final CurrentWeather currentWeather;
  final String cityName;

  const CurrentWeatherWidget({
    super.key,
    required this.currentWeather,
    required this.cityName,
  });

  String _getAnimationForCondition(String condition) {
    // Map weather descriptions to Lottie animation files
    switch (condition.toLowerCase()) {
      case 'clear sky':
        return 'assets/sunny.json';
      case 'few clouds':
      case 'scattered clouds':
      case 'broken clouds':
      case 'overcast clouds':
        return 'assets/cloudy.json';
      case 'shower rain':
      case 'rain':
      case 'heavy intensity rain':
      case 'light rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'snowing':
      case 'snow':
        return 'assets/snowing.json';
      case 'fog':
      case 'haze':
        return 'assets/fog.json';
      default:
        return 'assets/unknown.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    final feelsLike = currentWeather.feelsLike.round();
    final condition = currentWeather.weather[0].description;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            cityName,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Lottie.asset(
            _getAnimationForCondition(condition),
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            'Current Weather: ${currentWeather.temp.round()}°C',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
          'Feels like: $feelsLike °C',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            condition,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}