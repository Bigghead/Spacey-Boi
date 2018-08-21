import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../FullsizePage/fullsize_page.dart';

import '../../UI/side_drawer.dart';

class InfoPage extends StatefulWidget {

  final Map<dynamic, dynamic> apodInfo;

  InfoPage( { @required this.apodInfo } );

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _InfoPageState();
    }
}


class _InfoPageState extends State<InfoPage>{
  
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> _favorites = [];
  Map<dynamic, dynamic> _apodInfo;

  @override
  initState(){
    super.initState();
    _apodInfo = widget.apodInfo;
    _getFavorites();
  }


  Future<Null> _getFavorites() async {
    try {
      var prefs     = await _prefs;
      var favorites = prefs.getStringList('favorites');
      if( favorites != null ) {
        setState(() {
                _favorites = List.from(favorites);
              });
      } else {
        // first load won't have the prefs set 
        prefs.setStringList('favorites', []);
      }
    } catch( e ) { print(e); }
   
  }


  Future<Null> _toggleFavorites( String url ) async {
    try {

      var prefs     = await _prefs;
      var favorites = prefs.getStringList('favorites');
      
      if ( favorites.contains(url) ) {
        favorites.remove(url);
      } else {
        favorites.add(url);
      }
      prefs.setStringList('favorites', favorites);
      setState(() {
              _favorites = favorites;
            });

    } catch(e) { print(e); }
  }


  Widget _showMediaType( Map _apodInfo, BuildContext context ) {
    if( _apodInfo['media_type'] == 'image' ) {
      return Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: NetworkImage(_apodInfo['url']),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              ),
          ),
          Container(
            height: 40.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.85)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    _toggleFavorites(_apodInfo['url']);
                  },
                  icon: Icon(
                    _isFavorited(_apodInfo['url']) ? Icons.favorite : Icons.favorite_border, 
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: ( context ) => FullSizePage(hdurl: _apodInfo['url'],)
                    ));
                  },
                  icon: Icon(Icons.fullscreen, color: Colors.white,), 
                )              

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
            onPressed: () { _launchBrowser(_apodInfo['url']); },
            child: Text('Launch video in browser'),
          ),
        ],
      );
    }
  }


  bool _isFavorited( String url ) {
    return _favorites.contains(url);
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
                child:Text(_apodInfo['title'], style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontFamily: 'Oswald'
                ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(_apodInfo['date']),
                  _apodInfo['copyright'] != null ? Text(_apodInfo['copyright']) : Text(''),
                ],
              ),
                SizedBox(height: 15.0,),              
              _showMediaType(_apodInfo, context),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(_apodInfo['explanation'], style: TextStyle(
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