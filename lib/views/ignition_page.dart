import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:lottie/lottie.dart';

class IgnitionPage extends StatefulWidget {
  final SerialPort port;

  const IgnitionPage({Key? key, required this.port}) : super(key: key);

  @override
  State<IgnitionPage> createState() => _IgnitionPageState();
}

class _IgnitionPageState extends State<IgnitionPage> {
  int cuenta = 5;

  @override
  void initState() async {
    super.initState();
    widget.port.write(Uint8List.fromList('0'.codeUnits));
    for (int i = 0; i < cuenta; i++) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        cuenta--;
      });
    }
    if (widget.port.openReadWrite() != true) {
      print(SerialPort.lastError);
    }
    widget.port.write(Uint8List.fromList('1'.codeUnits));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: cuenta == 0
            ? Lottie.network(
                'https://assets5.lottiefiles.com/packages/lf20_yNhVL9.json')
            : Card(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Text('$cuenta'),
                ),
              ),
      ),
    );
  }
}
