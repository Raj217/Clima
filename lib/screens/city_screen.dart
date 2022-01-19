import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clima/services/weather.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? loc;

  @override
  Widget build(BuildContext context) {
    Color currentDarkColor = kDarkBlue;
    Color currentLightColor = kLightBlue;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  currentLightColor,
                  currentDarkColor,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1, 1),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 300),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: RotationTransition(
                            turns: const AlwaysStoppedAnimation(-30 / 360),
                            child: SvgPicture.asset(
                              '$locationScreenAssetsPath/Back.svg',
                              color: Colors.white,
                              height: 30,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 35),
                        child: TextField(
                          style: const TextStyle(
                            color: kBlue,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter City Name (eg. London, UK)',
                            hintStyle: TextStyle(color: kBlue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            loc = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () async {
                          dynamic weatherData;
                          if (loc != null) {
                            weatherData =
                                await WeatherModel().getNewWeather(loc!);
                          }
                          Navigator.pop(context, weatherData);
                        },
                        child: const Text(
                          'Get Weather',
                          style: TextStyle(
                            color: kBlue,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 9, horizontal: 11),
                            backgroundColor: Colors.white),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  '$locationScreenAssetsPath/Blue Mountains.png',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
