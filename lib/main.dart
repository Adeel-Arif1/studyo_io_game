import 'package:flutter/material.dart';
import 'package:studyo_io_app/slider_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
          debugShowCheckedModeBanner: false, 
      home: SliderScreen(),
    );
  }
}
