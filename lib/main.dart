import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './Pages/Homepage/homepage.dart';

void main() {
  debugPaintSizeEnabled=true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        routes: {
          '/': ( BuildContext context ) => HomePage(),
        },
      );
    }
}
