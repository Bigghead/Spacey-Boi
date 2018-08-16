import 'package:flutter/material.dart';


class InfoPage extends StatelessWidget {

  final Map<String, dynamic> apodInfo;

  InfoPage( { @required this.apodInfo } );


  Widget _showMediaType( String media ) {
    if( media == 'image' ) {
      return Image(image: NetworkImage(apodInfo['url']));
    } else {
      return Column(
        children: <Widget>[
          Card(
            child: Text('Launch video in browser'),
          ),
          Text('No Image Available')
        ],
      );
    }
  }


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
        body: Center(
          child: ListView(
            children: <Widget>[
              Container( 
                alignment: Alignment.center,
                child:Text(apodInfo['title']),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(apodInfo['date']),
                  apodInfo['copyright'] != null ? Text(apodInfo['copyright']) : Text(''),
                ],
              ),
              _showMediaType(apodInfo['media_type']),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(apodInfo['explanation'])
              )
            ],
          ),
        ),
      );
    }
}