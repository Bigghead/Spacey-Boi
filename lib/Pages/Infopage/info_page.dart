import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../UI/side_drawer.dart';

class InfoPage extends StatelessWidget {

  final Map<dynamic, dynamic> apodInfo;

  InfoPage( { @required this.apodInfo } );


  Widget _showMediaType( String media, BuildContext context ) {
    if( media == 'image' ) {
      return Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: NetworkImage(apodInfo['url']),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              ),
          ),
          Container(
            height: 30.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.85)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.file_download, color: Colors.white,),
                Icon(Icons.fullscreen, color: Colors.white,),                

              ],
            ),
          )
        ],
      );
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
        body: Container(
          decoration: BoxDecoration(
            color: Color(int.parse('#f9ebe0'.substring(1, 7), radix: 16) + 0xFF000000)
          ),
          child: ListView(
            children: <Widget>[
              Container( 
                margin: EdgeInsets.symmetric(vertical: 15.0),
                alignment: Alignment.center,
                child:Text(apodInfo['title'], style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontFamily: 'Oswald'
                ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(apodInfo['date']),
                  apodInfo['copyright'] != null ? Text(apodInfo['copyright']) : Text(''),
                ],
              ),
                SizedBox(height: 15.0,),              
              _showMediaType(apodInfo['media_type'], context),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(apodInfo['explanation'], style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Oswald',
                  // fontWeight: FontWeight.w400
                ),)
              )
            ],
          ),
        ),
      );
    }
}