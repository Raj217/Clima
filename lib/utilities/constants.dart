import 'package:flutter/material.dart';

// -------------------- Colors --------------------
const kLightBlue = Color(0xFF47caeb);
const kBlue = Color(0xFF00a0cc);
const kDarkBlue = Color(0xFF004f99);

// -------------------- Values --------------------
String apiKey = '6b3cd1ccc02888c9726dab5bc497d7e4';

// -------------------- Locations --------------------
String locationScreenAssetsPath = 'assets/images/location_screen';
String dayNightImagesPath = 'assets/images/weather_screen/day_night';
String weatherSVGsPath = 'assets/images/weather_screen/weather';
String weatherIconsPath = 'assets/images/weather_screen/weather';
String weatherDataIconsPath = 'assets/images/weather_screen/data';
String weatherNavigationIconsPath = 'assets/images/weather_screen/navigation';

// -------------------- Maps --------------------
Map<int, String> dateEndMapper = {
  1: 'st',
  2: 'nd',
  3: 'rd',
  21: 'st',
  22: 'nd',
  23: 'rd',
  31: 'st'
};

Map<int, String> monthIntToStr = {
  1: 'Jan',
  2: 'Feb',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'Aug',
  9: 'Sept',
  10: 'Oct',
  11: 'Nov',
  12: 'Dec'
};

Map<int, String> iconToSvg = {
  1: 'Clear-sky',
  2: 'Few-Clouds',
  3: 'Scattered-Clouds',
  4: 'Scattered-Clouds',
  9: 'Shower-Rain',
  10: 'Rain',
  11: 'Storm',
  13: 'Snow',
  50: 'Mist'
};
