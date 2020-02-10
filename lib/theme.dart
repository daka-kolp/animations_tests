import 'package:flutter/material.dart';

class RaMTheme {
  static final MaterialColor _materialColor =
      _createMaterialColor(Color(0xFF1EC9E8));
  static final MaterialAccentColor _accentColor =
      _createMaterialAccentColor(Color(0xFFA7E541));
  final ThemeData _themeData;

  ThemeData get themeData => _themeData;

  RaMTheme()
      : _themeData = ThemeData(
          brightness: Brightness.light,
          fontFamily: 'GloriaHallelujah',
//          fontFamily: 'OpenSans',
          primarySwatch: _materialColor,
          accentColor: _accentColor,
          canvasColor: Color(0xFFFFFCBB),
          bottomAppBarColor: Color(0xFFFFE9A0),
          cardColor: Color(0xFFFFE9A0),
          dividerColor: _materialColor[900],

          selectedRowColor: Color(0xFFFFFC99),
          unselectedWidgetColor: Color(0xAAFFE9A0),
          cursorColor: _materialColor[900],
          dialogBackgroundColor: Color(0xFFFFFCBB),
          hintColor: _materialColor[900],
          errorColor: Color(0xFFE20338),
          primaryIconTheme: IconThemeData(
            color: _materialColor[900],
          ),
          accentIconTheme: IconThemeData(
            color: _materialColor[900],
          ),
          iconTheme: IconThemeData(
            color: _materialColor[900].withOpacity(0.8),
          ),
          buttonColor: _accentColor[300],
          focusColor: _materialColor[900].withOpacity(0.12),
          hoverColor: _materialColor[900].withOpacity(0.04),
          disabledColor: _materialColor[100],
          splashColor: Color(0x66A7E541),
          highlightColor: Color(0x66A7E541),
        );
}

MaterialColor _createMaterialColor(Color color) {
  List strengths = <double>[.05];

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  final swatches = _generateSwatches(color, strengths);
  return MaterialColor(color.value, swatches);
}

MaterialAccentColor _createMaterialAccentColor(Color color) {
  List strengths = <double>[];

  for (int i = 0; i < 4; i++) {
    final last = strengths.lastWhere((_) => true, orElse: () => 0.1);
    strengths.add(last + i * 0.1);
  }

  final swatches = _generateSwatches(color, strengths);

  return MaterialAccentColor(color.value, swatches);
}

Map<int, Color> _generateSwatches(Color color, List<double> strengths) {
  Map<int, Color> swatches = {};

  final int r = color.red, g = color.green, b = color.blue;

  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatches[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });

  return swatches;
}
