import 'package:flutter/material.dart';
import '../models/weather_response.dart';
import '../pages/weather_details_page.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';


class DailyForecastList extends StatelessWidget {
  final List<DailyWeather> dailyForecast;

  const DailyForecastList({super.key, required this.dailyForecast});

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

  @override
  Widget build(BuildContext context) {
    // Log the daily forecast data
    dailyForecast.forEach((day) {
      print("Day: ${getDayName(day.dt)}, Condition: ${day.weather[0].description}"
      );
    });
    return ListView.builder(
        itemCount: dailyForecast.length,
        itemBuilder: (context, index) {
          final day = dailyForecast[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: ListTile(
              title: Text(
                  '${getDayName(day.dt)}: ${day.temp.day.round()}°C',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Feels Like: ${day.feelsLike.day.round()}°C',
                  style: TextStyle(fontSize: 16),
              ),
              leading: Lottie.asset(
                _getAnimationForCondition(day.weather[0].description),
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WeatherDetailPage(day: day),
                )
              ),
            ),
          );
        }
    );
  }
}