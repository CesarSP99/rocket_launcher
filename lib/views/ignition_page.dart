import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:lottie/lottie.dart';
import 'package:rocket_launcher/utils/custom_colors.dart';
import 'package:rocket_launcher/views/home_page.dart';

class IgnitionPage extends StatefulWidget {
  final SerialPort port;

  const IgnitionPage({Key? key, required this.port}) : super(key: key);

  @override
  State<IgnitionPage> createState() => _IgnitionPageState();
}

class _IgnitionPageState extends State<IgnitionPage> {
  List colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.orange
  ];

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
      backgroundColor: colors[cuenta],
      body: Center(
        child: cuenta == 0
            ? Lottie.asset('assets/lottie/cohete2.json')
            : Text(
                '$cuenta',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 300, fontWeight: FontWeight.bold),
              ),
      ),
      floatingActionButton: (cuenta == 0)
          ? FloatingActionButton(
              backgroundColor: CustomColors.greenUPSA,
              child: const Icon(Icons.refresh),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
                widget.port.close();
              },
            )
          : null,
    );
  }
}
