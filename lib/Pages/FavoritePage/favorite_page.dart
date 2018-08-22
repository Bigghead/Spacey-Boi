import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UI/side_drawer.dart';

class FavoritePage extends StatefulWidget {

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _FavoritePageState();
    }
}


class _FavoritePageState extends State<FavoritePage> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> _favorites = [];

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
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
      } 
    } catch( e ) { print(e); }
   
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
          child: _favorites.isEmpty 
            ? Center(child: Text('You have no pictures in your favorites'),)
            : Center(
              child: Column(
                children: _favorites.map((f) => Text(f)).toList(),
              ),
            ),
        ),
      );
    }
}