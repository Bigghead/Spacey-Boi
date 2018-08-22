import 'package:flutter/material.dart';

import '../../UI/side_drawer.dart';

class FavoritePage extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.85),
        ),
        drawer: SideDrawer(),
        body: Container(
          child: Text('hello'),
        ),
      );
    }
}