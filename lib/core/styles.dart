import 'package:flutter/material.dart';

class Styles {
  static LinearGradient appLinear = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF75BBFF), // Üst sağ köşe rengi (#77C1F7)
      Color(0xFFFFAC75), // Sol alt köşe rengi (#FFAC75)
    ],
  );

  static LinearGradient boxLinear = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xffFFEBE3), // Üst sağ köşe rengi (#77C1F7)
        const Color(0xFFFFAC75)
            .withOpacity(0.1), // Sol alt köşe rengi (#FFAC75)
      ],
      stops: const [
        0.3,
        0.9
      ]);

  static Color textColor = const Color(0xff454b60);
  static Color primaryColor = const Color(0xFFFFAC75);
  static Color warningRedColor = const Color(0xffED6E71);
  static Color greenColor = const Color(0xff70FF7A);
  static Color neutralsBlue = const Color(0xff454B60);
}
