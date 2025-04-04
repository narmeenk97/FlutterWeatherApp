import 'dart:convert';
import '../models/weather_response.dart';
import 'package:http/http.dart' as http;
import '../services/location_service_permission.dart';

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/3.0/onecall';
  final String apiKey;
  final LocationService locationService;

  WeatherService(this.apiKey, this.locationService);
  //Use the lat and lon values and the apiKey to fetch the weather data
  Future<WeatherResponse> getWeather(double latitude, double longitude) async {
    try {
      print('Fetching weather data for lat: $latitude, lon: $longitude');
      final response = await http
          .get(Uri.parse(
          '$BASE_URL?lat=$latitude&lon=$longitude&exclude=hourly,minutely&units=metric&appid=$apiKey'));
      //check to see if we're getting the right response
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Parsed data: $data');
        return WeatherResponse.fromJson(data);
      } else {
        print('Exception occurred with get weather');
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      throw Exception('Error fetching weather data: $error');
    }
  }
  Future<WeatherResponse> getWeatherByCoordinates() async {
    try {
      final position = await locationService.getCurrentLocation();
      print('position: $position');
      print('getWeatherByCoordinates works');
      return await getWeather(position.latitude, position.longitude);
    } catch (error) {
      throw Exception('Error fetching weather data: $error');
    }
  }
}