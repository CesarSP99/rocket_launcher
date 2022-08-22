import 'package:flutter/material.dart';

import 'views/launch_page.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const LaunchPage(title: 'Rocket Launcher'),
    );
  }
}
