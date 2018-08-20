import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../../Store/gallery_image_store.dart';

import '../Infopage/info_page.dart';
import '../../UI/side_drawer.dart';

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
      super.initState();
    }

  void _getDates() {
    for( var i = 0 ; i < 60; i ++ ) {
      dates.add(getDate(i));
    }
  }

  Widget _getPictureFromModel( GalleryData store, String date ) {
    Map data = store.getData(date);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
                  builder: (context) => InfoPage(apodInfo: data,)
                ));
      },
      child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: data['media_type'] == 'image'
                    ? FadeInImage(
                      placeholder: AssetImage('assets/loading.gif'),
                      fit: BoxFit.cover,
                      image: NetworkImage(data['url']),
                      height: double.infinity,
                      width: double.infinity,
                      // alignment: Alignment.center,
                    )
                    : Image(image: NetworkImage('https://imgplaceholder.com/420x320/ffffff/000000?text=Video+Image'),),
              ),
    );
  }


  Future<Map> _getPictureUrl( GalleryData store, String date ) async {
      try {
        final http.Response response = await http.get('https://api.nasa.gov/planetary/apod?date=${date}&api_key=${api_key}');
        final Map data = await json.decode(response.body);
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
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: snapshot.data['media_type'] == 'image'
                    ? FadeInImage(
                      placeholder: AssetImage('assets/loading.gif'),
                      fit: BoxFit.cover,
                      image: NetworkImage(snapshot.data['url']),
                      height: double.infinity,
                      width: double.infinity,
                      // alignment: Alignment.center,
                    )
                    : Image(image: NetworkImage('https://imgplaceholder.com/420x320/ffffff/000000?text=Video+Image'),),
              ),
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