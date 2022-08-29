import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:gauges/gauges.dart';
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
  bool _isPressed = false;
  double _fuelPointer = -100;
  bool _isFull = false;

  Future fuelRocket() async {
    do {
      if (_fuelPointer < 100) {
        await Future.delayed(const Duration(milliseconds: 25));
        setState(() {
          _fuelPointer += 1;
        });
      } else {
        setState(() {
          _isFull = true;
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => IgnitionPage(
              port: widget.port,
            ),
          ),
        );
      }
    } while (_isPressed && !_isFull);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "Rocket Launcher",
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const FittedBox(
              child: Text(
                "Lanzador de Cohetes UPSA",
                style: TextStyle(fontSize: 50),
              ),
            ),
            (_isPressed)
                ? const FittedBox(
                    child: Text(
                    'Cargando H2 Verde...',
                    style: TextStyle(fontSize: 30),
                  ))
                : const SizedBox(
                    height: 35,
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
                            onLongPressStart: (_) {
                              setState(() {
                                _isPressed = true;
                              });
                              fuelRocket();
                            },
                            onLongPressEnd: (_) {
                              setState(() {
                                _isPressed = false;
                              });
                            },
                            child: Column(
                              children: [
                                Lottie.asset(
                                  'assets/lottie/manguera.json',
                                  width: 180,
                                ),
                                Center(
                                    child: (!_isPressed)
                                        ? const Text('Presiona aquí!')
                                        : null)
                              ],
                            )),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Lottie.asset(
                        'assets/lottie/cohete1.json',
                        width: 550,
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: Center(
                          child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 250),
                              child: Column(
                                children: [
                                  RadialGauge(
                                    axes: [
                                      RadialGaugeAxis(
                                          color: Colors.transparent,
                                          minValue: -100,
                                          maxValue: 100,
                                          minAngle: -150,
                                          maxAngle: 150,
                                          radius: 0.6,
                                          width: 0.2,
                                          segments: [
                                            const RadialGaugeSegment(
                                              minValue: 0,
                                              maxValue: 20,
                                              minAngle: -150,
                                              maxAngle: -90,
                                              color: Colors.red,
                                            ),
                                            const RadialGaugeSegment(
                                              minValue: 20,
                                              maxValue: 40,
                                              minAngle: -90,
                                              maxAngle: -30,
                                              color: Colors.orange,
                                            ),
                                            const RadialGaugeSegment(
                                              minValue: 40,
                                              maxValue: 60,
                                              minAngle: -30,
                                              maxAngle: 30,
                                              color: Colors.yellow,
                                            ),
                                            const RadialGaugeSegment(
                                              minValue: 60,
                                              maxValue: 80,
                                              minAngle: 30,
                                              maxAngle: 90,
                                              color: Colors.lightGreen,
                                            ),
                                            const RadialGaugeSegment(
                                              minValue: 80,
                                              maxValue: 100,
                                              minAngle: 90,
                                              maxAngle: 150,
                                              color: Colors.green,
                                            ),
                                          ],
                                          pointers: [
                                            RadialNeedlePointer(
                                                value: _fuelPointer,
                                                thicknessStart: 20,
                                                thicknessEnd: 0,
                                                length: 0.6,
                                                knobRadiusAbsolute: 10,
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Colors.black,
                                                      Colors.grey
                                                    ]))
                                          ]),
                                    ],
                                  ),
                                ],
                              )),
                        ))
                  ],
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.red,
                //     shape: const CircleBorder(),
                //     padding: const EdgeInsets.all(20),
                //   ),
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => IgnitionPage(
                //           port: widget.port,
                //         ),
                //       ),
                //     );
                //   },
                //   child: const Icon(
                //     Icons.rocket_launch,
                //     size: 50,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
