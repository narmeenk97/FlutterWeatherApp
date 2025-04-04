import 'package:final_project_template/widgets/daily_forecast_listview.dart';
import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_response.dart';
import '../services/location_service_permission.dart';
import '../widgets/current_weather_widget.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //api key
  final weatherService = WeatherService('6c287a0a60da34f0725f72b519b8d94e', LocationService());
  WeatherResponse? _weather;
  String? _cityName;
  bool _loading = true;
  String? _errorMessage;

  //fetch the weather as soon as the app is opened
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      print('fetching weather');
      final cityName = await weatherService.locationService.getCurrentCity();
      print('City name: $cityName');
      final weatherResponse = await weatherService.getWeatherByCoordinates();
      print('weather data fetched');
      print("Daily weather data: ${weatherResponse.daily}");
      setState(() {
        _weather = weatherResponse;
        _cityName = cityName;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _loading = false;
      });
    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,

          title: Text(widget.title),
        ),
          body: Center(
          child: _loading
            ? CircularProgressIndicator()
              : _errorMessage != null
                ? Text(_errorMessage!)
                  : _weather != null && _cityName != null
                      ? Column(
                          children: [
                            CurrentWeatherWidget(
                            currentWeather: _weather!.current,
                            cityName: _cityName!,
                            ),
                          Expanded(
                          child: DailyForecastList(
                            dailyForecast: _weather!.daily.sublist(1, 6),
                          ),
                          ),
                          ],
          ) : Text('Unable to fetch weather data'),
        ),
      );
    }
}

