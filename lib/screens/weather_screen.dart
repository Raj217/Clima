import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key, this.locationWeather}) : super(key: key);
  final dynamic locationWeather;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String bgImg = '';
  String cityName = '';
  String time = '';
  String date = '';
  String temperature = '';
  String weatherSVG = '';
  String weatherMain = '';
  String weatherDesc = '';
  String percentOfPrec = '';
  String uv = '';
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather[1]);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      int iconCode = int.parse(
          weatherData['icon'].substring(0, weatherData['icon'].length - 1));
      String? svgName =
          iconToSvg.containsKey(iconCode) ? iconToSvg[iconCode] : 'Error';

      if ([1, 2].contains(iconCode)) {
        if (weatherData[weatherData['icon'].length - 1] == 'd') {
          svgName = svgName! + '-sun';
        } else {
          svgName = svgName! + '-moon';
        }
      }

      bgImg =
          '$dayNightImagesPath/${weatherData['icon'][weatherData['icon'].length - 1] == 'd' ? 'Morning.png' : 'Night.png'}';
      cityName = weatherData['cityName'];
      time = weatherData['time'];
      date = weatherData['date'];
      temperature = weatherData['temperature'];
      weatherSVG = '$weatherIconsPath/$svgName.svg';
      weatherMain = weatherData['weatherMain'];
      weatherDesc = weatherData['weatherDesc'];
      percentOfPrec = ' ${weatherData['pop']} ';
      uv = ' ${weatherData['uv']}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImg),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                dynamic weatherData =
                                    await WeatherModel().getLocationWeather();
                                updateUI(weatherData[1]);
                              },
                              child: SvgPicture.asset(
                                '$weatherNavigationIconsPath/MyLocation.svg',
                                color: Colors.white,
                                height: 30,
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () async {
                                dynamic weatherData =
                                    await WeatherModel().updateWeather();
                                updateUI(weatherData[1]);
                              },
                              child: SvgPicture.asset(
                                '$weatherNavigationIconsPath/Reload.svg',
                                color: Colors.white,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            var weatherData = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const CityScreen();
                                },
                              ),
                            );
                            if (weatherData != null) {
                              updateUI(weatherData[1]);
                            }
                          },
                          child: SvgPicture.asset(
                            '$weatherNavigationIconsPath/ChangeLoc.svg',
                            color: Colors.white,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(
                                cityName,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          time,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          temperature,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w100,
                            fontSize: 100,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 65),
                          child: Icon(FontAwesomeIcons.circle, size: 17),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 55, left: 5),
                          child: Text(
                            'C',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          weatherSVG,
                          color: Colors.white,
                          height: 30,
                        ),
                        Text(
                          weatherMain,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          weatherDesc,
                          style: const TextStyle(
                              fontFamily: 'Poppins', fontSize: 10),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            SvgPicture.asset(
                              '$weatherDataIconsPath/Precipitation.svg',
                              color: Colors.white,
                              height: 15,
                            ),
                            Text(
                              percentOfPrec,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            SvgPicture.asset(
                              '$weatherDataIconsPath/UV.svg',
                              color: Colors.white,
                              height: 15,
                            ),
                            Text(
                              uv,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
