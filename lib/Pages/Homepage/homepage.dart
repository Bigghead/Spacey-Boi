import 'package:flutter/material.dart';

import './daily_pic.dart';
import '../../UI/side_drawer.dart';

class HomePage extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.85),
        ),
        drawer: SideDrawer(),
        body: Column(
          children: <Widget>[
              Flexible( flex: 2, child: DailyPic(widgetText: 'Picture of the day', pictureType: 'daily',),),
              Flexible(
                flex: 1,
                child:Row(
                children: <Widget>[
                  Expanded(
                    child: DailyPic(widgetText: 'Gallery', pictureType: 'gallery',),
                  ),
                  Expanded(
                    child: DailyPic(widgetText: 'Random', pictureType: 'random',),
                  )
                ],
              )),
             
          ],
        )
      );
    }
}