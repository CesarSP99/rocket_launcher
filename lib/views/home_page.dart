import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'fuel_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xff0b5842),
        title: const Text('Rocket Launcher UPSA'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Seleccione el puerto serial a usar:'),
            DropdownButton(
              value: selectedAddress,
              items: SerialPort.availablePorts
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (String? selection) {
                setState(() {
                  selectedAddress = selection;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: 130,
              child: ElevatedButton(
                // style: ElevatedButton.styleFrom(
                //   primary: const Color(0xff89c970),
                // ),
                onPressed: selectedAddress == null
                    ? null
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FuelPage(
                              port: SerialPort(selectedAddress!),
                            ),
                          ),
                        );
                      },
                child: Row(
                  children: const [
                    Text("Siguiente"),
                    Icon(Icons.arrow_right_alt_outlined),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
