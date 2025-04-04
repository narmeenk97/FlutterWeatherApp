//this file gets all the necessary permissions from the user when getting their location
//it also gets their current position that we use with the weather_service to fetch the weather
//we will get the city name using the coordinates we get from getCurrentLocation, so we can display it on the current weather widget
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    //check the location permission
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions denied!');
      }
    }

    // Get current location
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> getCurrentCity() async {
    //get the current location from getCurrentLocation
    Position position = await getCurrentLocation();
    //convert the location to a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //extract the city name from the first placemark
    String? city = placemarks[0].locality;
    return city ?? '';
  }
}