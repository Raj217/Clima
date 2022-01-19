import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'weather_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Geolocator.requestPermission();
    getLocationData();
  }

  void getLocationData() async {
    if (await Geolocator.checkPermission() == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WeatherScreen(
            locationWeather: weatherData,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kBlue,
        child: const Center(
          child: SpinKitFoldingCube(
            color: Colors.white,
            size: 80.0,
          ),
        ),
      ),
    );
  }
}
