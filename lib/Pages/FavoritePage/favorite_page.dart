import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';


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


  Widget _renderFavoriteImages() {
    return CarouselSlider(
  items: _favorites.map((i) {
    return new Builder(
      builder: (BuildContext context) {
        return new Container(
          margin: new EdgeInsets.all(5.0),
          child: new ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
              child: Image(
                image: NetworkImage(i),
                fit: BoxFit.cover,
                width: 1000.0,
            )
          )
        );
      },
    );
  }).toList(),
  viewportFraction: 0.8,
  height: MediaQuery.of(context).size.height * 0.8,
  autoPlay: false,
  reverse: false,
);
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
              child: _renderFavoriteImages(),
            ),
        ),
      );
    }
}