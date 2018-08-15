import 'package:flutter/material.dart';

import './Pages/Homepage/homepage.dart';

void main() => runApp(new MyApp());

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
