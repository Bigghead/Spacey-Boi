import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../UI/side_drawer.dart';

class InfoPage extends StatelessWidget {

  final Map<String, dynamic> apodInfo;

  InfoPage( { @required this.apodInfo } );


  Widget _showMediaType( String media ) {
    if( media == 'image' ) {
      return Image(image: NetworkImage(apodInfo['url']));
    } else {
      return Column(
        children: <Widget>[
          Text('No Image Available'),
          SizedBox(height: 10.0,),
          RaisedButton(
            onPressed: () { _launchBrowser(apodInfo['url']); },
            child: Text('Launch video in browser'),
          ),
        ],
      );
    }
  }


  Future<Null> _launchBrowser( String url ) async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.85),
        ),
        drawer: SideDrawer(),
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