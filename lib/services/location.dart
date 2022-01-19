import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Loc {
  double latitude = 0;
  double longitude = 0;
  List<Placemark>? cityName;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;
      cityName = await getCityName(latitude, longitude);
    } catch (e) {
      // TODO: Change print with alert
      print('Loc: $e');
    }
  }

  Future<List<Placemark>> getCityName(double latitude, double longitude) async {
    return await placemarkFromCoordinates(latitude, longitude);
  }

  Future<List<Location>> getLocationFromAddress(String query) async {
    return await locationFromAddress(query);
  }
}
