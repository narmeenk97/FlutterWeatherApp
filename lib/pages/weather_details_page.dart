import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../models/weather_response.dart';

class WeatherDetailPage extends StatelessWidget {
  final DailyWeather day;

  const WeatherDetailPage({super.key, required this.day});
  String _getAnimationForCondition(String condition) {
    // Print the condition to debug
    print("Weather condition: $condition");
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
        return 'assets/fog.json';
      default:
        return 'assets/unknown.json';
    }
  }
  String getDayName(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('EEEE').format(date);
  }
  String formatTime(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('h:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final condition = day.weather[0].description;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getDayName(day.dt),
        ),
      ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            _getAnimationForCondition(condition),
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 70),
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Temperature: ${day.temp.day.round()}°C',
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  'Feels like: ${day.feelsLike.day.round()}°C',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Sunrise: ${formatTime(day.sunrise)}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Sunset: ${formatTime(day.sunset)}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Wind Speed: ${day.windSpeed.round()} m/s',
                  style: TextStyle(fontSize: 20),
                ),
                if (day.rain != null)
                  Text( 'Rain: ${day.rain} mm',
                    style: TextStyle(fontSize: 20),
                  ),
                if (day.snow != null)
                  Text( 'Snow: ${day.snow} mm',
                    style: TextStyle(fontSize: 20),
                  ),
                Text(
                  'UV Index: ${day.uvi}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Weather: ${day.weather[0].description}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Summary: ${day.summary}',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          )
        ],
      ),
    )
    );
  }
}