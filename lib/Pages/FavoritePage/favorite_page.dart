import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
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


  bool _isFavorited(String url ) {
    return _favorites.contains(url);
  }


  Widget _renderFavoriteImages() {
    return CarouselSlider(
      items: _favorites.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 5.0, left: 5.0, right: 5.0),
              child: Column(
                children: <Widget>[
                Expanded(
                  child: ClipRRect(
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                    child: Image(
                      image: CachedNetworkImageProvider(i),
                      fit: BoxFit.cover,
                      width: 1000.0,
                  )
                ),
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                  ),
                  child: IconButton(
                    onPressed: () => _toggleFavorites(i),
                    icon: Icon(_isFavorited(i) ? Icons.favorite : Icons.favorite_border),
                  )
                )
                ],
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
          decoration: BoxDecoration(
            color: Color(int.parse('#f9ebe0'.substring(1, 7), radix: 16) + 0xFF000000)
          ),
          child: _favorites.isEmpty 
            ? Center(child: Text('You have no pictures in your favorites'),)
            : Center(
              child: _renderFavoriteImages(),
            ),
        ),
      );
    }
}