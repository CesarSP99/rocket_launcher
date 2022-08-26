import 'package:flutter/material.dart';

class CustomColors {
  static const MaterialColor greenUPSA = MaterialColor(
    0xff0b5842, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff0a4f3b), //10%
      100: Color(0xff094635), //20%
      200: Color(0xff083e2e), //30%
      300: Color(0xff073528), //40%
      400: Color(0xff062c21), //50%
      500: Color(0xff04231a), //60%
      600: Color(0xff031a14), //70%
      700: Color(0xff02120d), //80%
      800: Color(0xff010907), //90%
      900: Color(0x00000000), //100%
    },
  );
} //
