import 'networking.dart';
import 'location.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/utilities/globals.dart';

class WeatherModel {
  dynamic weatherData;
  Loc location = Loc();
  String currentCityName = '';
  List<Location>? cityLoc;

  dynamic getLocationWeather() async {
    // Returns list containing response (0-success, 1-error) and the data
    try {
      await location.getCurrentLocation();

      coordinates.updateLocByVal(location.longitude, location.latitude);

      weatherData = await _getData(location.latitude, location.longitude);
      currentCityName = location.cityName![0].locality.toString();

      return [0, _getWeatherDetails()];
    } catch (e) {
      // TODO: Change print with alert
      print(e);
      return [1, getEmptyData()];
    }
  }

  dynamic getNewWeather(String loc) async {
    try {
      Map data = await coordinates.updateLocByText(loc);
      weatherData = await _getData(data['latitude'], data['longitude']);

      List<Placemark> temp =
          await Loc().getCityName(data['latitude'], data['longitude']);
      currentCityName = await temp[0].locality!;

      return [0, _getWeatherDetails()];
    } catch (e) {
      print(e);
      return [1, getEmptyData()];
    }
  }

  dynamic updateWeather() async {
    try {
      List<double> coord = coordinates.getLoc();
      weatherData = await _getData(coord[0], coord[1]);

      List<Placemark> temp = await Loc().getCityName(coord[0], coord[1]);
      currentCityName = await temp[0].locality!;

      return [0, _getWeatherDetails()];
    } catch (e) {
      print(e);
      return [1, getEmptyData()];
    }
  }

  dynamic _getData(double latitude, double longitude) async {
    NetworkHandler networkHandler = NetworkHandler(
        'http://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey');
    return await networkHandler.getData();
  }

  Map<String, dynamic> _getWeatherDetails() {
    String temp = weatherData['current']['temp'].toStringAsFixed(0);
    double uvi = weatherData['current']['uvi'].toDouble();
    String uv = '';

    if (uvi <= 2) {
      uv = 'Low';
    } else if (uvi <= 5) {
      uv = 'Moderate';
    } else if (uvi <= 7) {
      uv = 'High';
    } else if (uvi <= 10) {
      uv = 'Very High';
    } else {
      uv = 'Extreme';
    }

    String weatherMain =
        weatherData['current']['weather'][0]['main'].toString();
    String weatherDesc =
        weatherData['current']['weather'][0]['description'].toString();
    weatherDesc = weatherDesc[0].toUpperCase() + weatherDesc.substring(1);
    String precipitationProb =
        (weatherData['hourly'][0]['pop'] * 100).toStringAsFixed(0) + '%';
    String icon = weatherData['current']['weather'][0]['icon'].toString();

    DateTime dt = DateTime.fromMillisecondsSinceEpoch(
        (weatherData['current']['dt'].toInt() +
                weatherData['timezone_offset']) *
            1000,
        isUtc: true);
    DateFormat timeExtractor = DateFormat('jm');
    DateFormat dateExtractor = DateFormat('dd');
    DateFormat monthExtractor = DateFormat('MM');
    DateFormat dayExtractor = DateFormat('EEEE');

    String time = timeExtractor.format(dt).toString();
    int date = int.parse(dateExtractor.format(dt));
    String month = monthIntToStr[(int.parse(monthExtractor.format(dt)))]!;
    String day = dayExtractor.format(dt).toString();

    String cityName = currentCityName != ''
        ? currentCityName.toUpperCase()
        : coordinates.getCityName().toUpperCase();

    String? dateEnd =
        [1, 2, 3, 21, 22, 23, 31].contains(date) ? dateEndMapper[date] : 'th';
    Map<String, dynamic> data = {
      'time': time,
      'temperature': temp,
      'uv': uv,
      'weatherMain': weatherMain,
      'weatherDesc': (weatherDesc == weatherMain) ? '' : weatherDesc,
      'pop': precipitationProb,
      'icon': icon,
      'date': '$day, $month $date$dateEnd',
      'cityName': cityName
    };
    return data;
  }

  Map<String, dynamic> getEmptyData() {
    Map<String, dynamic> data = {
      'time': '00:00',
      'temperature': '0',
      'uvi': '0',
      'weatherMain': '',
      'weatherDesc': '',
      'icon': '00d',
      'date': '',
      'cityName': ''
    };
    return data;
  }
}
