import 'package:flutter/material.dart';

import './daily_pic.dart';

class HomePage extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Text('Hello Again')
            ],
          ),
        ),
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