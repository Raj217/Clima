import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const Clima());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class Clima extends StatelessWidget {
  const Clima({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}
