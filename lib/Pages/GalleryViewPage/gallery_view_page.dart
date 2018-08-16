import 'package:flutter/material.dart';

import '../../UI/side_drawer.dart';

import '../../utils.dart';


class GalleryViewPage extends StatefulWidget {

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _GalleryState();
    }
}

class _GalleryState extends State<GalleryViewPage> {

  List<String> dates = [];

  @override
    void initState() {
      // TODO: implement initState
      for( var i = 1; i <= 60 ; i ++ ) {
        dates.add(getDate(i));
      }
      print(dates);
      super.initState();
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.85),
        ),
        drawer: SideDrawer(),
        body: Center(child: Text('Meep'),),
      );
    }
}