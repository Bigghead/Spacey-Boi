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
              Expanded( child: DailyPic(),),
              Row(
                children: <Widget>[
                  Expanded(
                    child: DailyPic(),
                  ),
                  Expanded(
                    child: DailyPic(),
                  )
                ],
              )
             
          ],
        )
      );
    }
}