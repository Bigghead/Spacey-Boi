import 'package:flutter/material.dart';

import '../../UI/side_drawer.dart';

class FullSizePage extends StatelessWidget {

  final String hdurl;

  FullSizePage( { @required this.hdurl} );

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.85),
        ),
        drawer: SideDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(hdurl),
            fit: BoxFit.cover,
            height: double.infinity,
          ),
        ),
      );
    }
}