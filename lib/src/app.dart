import 'package:flutter/material.dart';
import 'package:objectbox_flutter/src/screens/weather/index.dart';

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
       home: WeatherScreen(),
    );
  }
}