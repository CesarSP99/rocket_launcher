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

  void cuentaRegresiva() async {
    if (widget.port.openReadWrite() != true) {
      print(SerialPort.lastError);
    }
    widget.port.write(Uint8List.fromList('1'.codeUnits));
    while (cuenta > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        cuenta--;
      });
    }
    widget.port.write(Uint8List.fromList('0'.codeUnits));
  }

  @override
  void initState() {
    super.initState();
    cuentaRegresiva();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: cuenta == 0
            ? Lottie.network(
                'https://assets5.lottiefiles.com/packages/lf20_yNhVL9.json')
            : Text(
                '$cuenta',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 150, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
