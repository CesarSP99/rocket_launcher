import 'package:flutter/material.dart';
import 'package:rocket_launcher/utils/custom_colors.dart';
import 'views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launcher',
      theme: ThemeData(
        primarySwatch: CustomColors.greenUPSA,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
