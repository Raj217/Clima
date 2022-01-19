import 'package:clima/services/location.dart';
import 'package:geocoding/geocoding.dart';

class Coordinates {
  double _lat = 0;
  double _long = 0;
  String _cityName = '';

  Future<Map<String, dynamic>> updateLocByText(String location) async {
    List<Location> newLoc = await Loc().getLocationFromAddress(location);
    _lat = newLoc[0].latitude;
    _long = newLoc[0].longitude;

    int index = location.indexOf(',');
    index != -1
        ? _cityName = location.substring(0, index).trim()
        : _cityName = location.trim();

    return <String, dynamic>{
      'latitude': _lat,
      'longitude': _long,
      'cityName': _cityName
    };
  }

  void updateLocByVal(double long, double lat) {
    _lat = lat;
    _long = long;
  }

  List<double> getLoc() {
    return [_lat, _long];
  }

  String getCityName() {
    return _cityName;
  }
}

Coordinates coordinates = Coordinates();
