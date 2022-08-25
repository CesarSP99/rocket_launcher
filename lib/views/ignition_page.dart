import 'dart:io';
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
    // Process.run('mode', [widget.port.name!, 'BAUD=9600', 'PARITY=n', 'DATA=8'],
    //     runInShell: true);
    if (widget.port.openReadWrite() != true) {
      print(SerialPort.lastError);
    }

    var config = widget.port.config;
    config.baudRate = 9600;
    config.bits = 8;
    config.stopBits = 1;
    config.parity = 0;
    widget.port.config = config;

    while (cuenta > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        cuenta--;
      });
    }

    widget.port.write(Uint8List.fromList('1'.codeUnits));
    //Process.run('echo', ['1', '>', widget.port.name!], runInShell: true);
    await Future.delayed(const Duration(seconds: 1));
    widget.port.write(Uint8List.fromList('0'.codeUnits));
    //Process.run('echo', ['0', '>', widget.port.name!], runInShell: true);
    //widget.port.close();
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
