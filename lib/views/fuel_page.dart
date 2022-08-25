import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';

import 'ignition_page.dart';

class FuelPage extends StatefulWidget {
  final SerialPort port;

  const FuelPage({Key? key, required this.port}) : super(key: key);

  @override
  State<FuelPage> createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rocket Launcher",
        ),
      ),
      body: Column(
        children: [
          const FittedBox(
            child: Text("Lanzador de Cohetes UPSA"),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: GestureDetector(
                          onLongPress: () {
                            // Start Fueling Animation
                          },
                          onLongPressEnd: (_) {
                            // Activate Launch button
                          },
                          child: Lottie.asset(
                            'assets/lottie/manguera.json',
                            height: 200,
                          )
                          // ElevatedButton(
                          //   onPressed: () => {},
                          //   style: ElevatedButton.styleFrom(
                          //     shape: RoundedRectangleBorder(),
                          //   ),
                          //   child: const Icon(Icons.local_gas_station),
                          // ),
                          ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Lottie.asset(
                      'assets/lottie/cohete1.json',
                      height: 400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => IgnitionPage(
                        port: widget.port,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.rocket_launch,
                  size: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
