import 'package:flutter/material.dart';


class InfoPage extends StatelessWidget {

  final Map<String, dynamic> apodInfo;

  InfoPage( { @required this.apodInfo } );

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
        body: Center(child: Text(apodInfo['title']),),
      );
    }
}