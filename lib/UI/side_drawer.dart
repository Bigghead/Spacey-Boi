import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


import '../Pages/Homepage/homepage.dart';
import '../Pages/GalleryViewPage/gallery_view_page.dart';
import '../Pages/FavoritePage/favorite_page.dart';
import '../Pages/Infopage/info_page.dart';

import '../keys.dart';

class SideDrawer extends StatelessWidget {


  List<Widget> _buildDrawerChildren(context) {
    final List<Map> children = [
      { 'icon': Icons.home, 'text': 'Home', 'navigate': HomePage() },
      { 'icon': Icons.photo, 'text': 'Gallery', 'navigate': GalleryViewPage() },      
      { 'icon': Icons.favorite, 'text': 'Favorites', 'navigate': FavoritePage() },
      // { 'icon': 'home', 'text': 'Home' },      
    ];

    return children.map( (f) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => f['navigate']
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Icon(f['icon'], color: Colors.white,),
              ),
              Expanded(
                child: Text(f['text'], style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }


  Future<Null> _getDate( BuildContext context, DateTime date ) async {

   try {

      if( date != null ) {
        DateFormat formatted = DateFormat('yyyy-MM-dd');
        String url = 'https://api.nasa.gov/planetary/apod?date=${formatted.format(date)}&api_key=${api_key}';

        http.Response response = await http.get(url);
        final Map data = await json.decode(response.body);
        Navigator.push(context, MaterialPageRoute(
          builder: ( BuildContext context ) => InfoPage(apodInfo: data,)
        ));
      }

   } catch (e) { print(e); }
    
  }


  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.85)
            ),
            child: Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.black.withOpacity(0.85),
                  leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.menu),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: List.from(_buildDrawerChildren(context))..addAll([
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            showDatePicker(
                                  context    : context,
                                  initialDate: DateTime.now(),
                                  firstDate  : DateTime.now().subtract(new Duration(days: 30 * 12)),
                                  lastDate   : DateTime.now(),
                            ).then((date) => _getDate(context, date));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Icon(Icons.date_range, color: Colors.white,),
                              ),
                              Expanded(
                                child: Text('Date', style: TextStyle(color: Colors.white),),
                              ),
                            ],
                          ),
                        ),
                      )
                    ])
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
}