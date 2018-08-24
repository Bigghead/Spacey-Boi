import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:sticky_headers/sticky_headers.dart';

// import 'package:shared_preferences/shared_preferences.dart';

import '../../Store/gallery_image_store.dart';

import '../Infopage/info_page.dart';
import '../../UI/side_drawer.dart';
import '../../UI/image_container.dart';

import '../../keys.dart';
import '../../utils.dart';


class GalleryViewPage extends StatefulWidget {

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _GalleryState();
    }
}

class _GalleryState extends State<GalleryViewPage> {

  List<String> dates = [];

  @override
    void initState() {
      // TODO: implement initState
      _getDates();
      // _clearPrefs();
      super.initState();
    }

  void _getDates() {
    for( var i = 0 ; i < 60; i ++ ) {
      dates.add(getDate(i));
    }
  }

  // Future<Null> _clearPrefs() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  // }

  Widget _getPictureFromModel( GalleryData store, String date ) {
    Map data = store.getData(date);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
                  builder: (context) => InfoPage(apodInfo: data,)
                ));
      },
      child: ImageContainer(data: data,),
    );
  }


  Future<Map> _getPictureUrl( GalleryData store, String date ) async {
      try {
        final http.Response response = await http.get('https://api.nasa.gov/planetary/apod?date=${date}&api_key=${api_key}');
        final Map data = await json.decode(response.body);
        if( data['url'].contains('.gif') ) {
          data['url'] = 'https://imgplaceholder.com/420x320/f9ebe0/4c4747?text=Image+Not+Found';
        }
        store.addData(date, data);
        return data;
      } catch(e) { 
        print(date);
        return e; 
      }
  }


  Widget _buildAsyncListView( GalleryData data,String date ) {
    return FutureBuilder(
      future: _getPictureUrl(data, date),
      builder: ( context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => InfoPage(apodInfo: snapshot.data,)
                ));
              },
              child: Material(
                color: Colors.grey[300],
                child: StickyHeaderBuilder(
                  overlapHeaders: true,
                  builder: (BuildContext context, double stuckAmount) {
						      	stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
						      	return new Container(
						      		height: 50.0,
						      		color: Colors.grey[900].withOpacity(0.6 + stuckAmount * 0.4),
						      		padding: new EdgeInsets.symmetric(horizontal: 16.0),
						      		alignment: Alignment.centerLeft,
						      		child: new Text('Hello',
						      			style: const TextStyle(color: Colors.white),
						      		),
						      	);
						      },
                  content: ImageContainer(data: snapshot.data,),
                ),
              ),
              // child: ImageContainer(data: snapshot.data,),
            )
            : Image(image: AssetImage('assets/loading.gif'));
     },
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
        body: dates.length == 0 
            ? Center(child: Image(image: AssetImage('assets/loading.gif'),),)
            : Container(
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: ScopedModelDescendant(
                builder: ( BuildContext context, Widget child , GalleryData store){
                  return ListView.builder(
                    itemCount: dates.length,
                    itemBuilder: ( BuildContext context, int index ) {
                      return store.hasData(dates[index]) 
                        ? _getPictureFromModel(store, dates[index])
                        : _buildAsyncListView( store ,dates[index]);
                    },
                  );
                }
              ),
            ),
      );
    }
}