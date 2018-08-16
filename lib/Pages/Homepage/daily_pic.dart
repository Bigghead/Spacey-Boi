import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../keys.dart';
import './fake_data.dart';


class DailyPic extends StatefulWidget {

  final String widgetText;
  final String pictureType;

  DailyPic( { @required this.widgetText, @required this.pictureType } );

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _DailyPicState();
    }
}


class _DailyPicState extends State<DailyPic> {

  // final Map _url = {
  //   'daily': 'https://api.nasa.gov/planetary/apod?api_key=${api_key}',
  //   'gallery': 'https://api.nasa.gov/planetary/apod?date=${_getYesterdayDate()}api_key=${api_key}'
  // };

  String _url = '';
  Map _dailyData = {};
  String _widgetText;
  String _pictureType;


  @override
  initState(){
    _getDailyData();
    // _dailyData   = fakeData;
    _widgetText  = widget.widgetText;
    _pictureType = widget.pictureType;
    switch( _pictureType ) {
      case 'daily':
        _url = 'https://api.nasa.gov/planetary/apod?api_key=${api_key}';
        return;
      case 'gallery':
        _url = 'https://api.nasa.gov/planetary/apod?date=${_getPicture(1)}&api_key=${api_key}';
        return;
      case 'random':
        _url = 'https://api.nasa.gov/planetary/apod?date=${_getPicture(Random().nextInt(30))}&api_key=${api_key}';
    }
    super.initState();
  }

  String _getPicture( int day) {
    var now = new DateTime.now();
    var yesterday = DateTime(now.year, now.month, now.day - (day) );
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(yesterday);
    return formattedDate;
  }

  Future<Null> _getDailyData() async {

    try {

      final http.Response response = await http.get(_url);
      final Map data = await json.decode(response.body);
      setState(() {
              _dailyData = data;
            });

    } catch(e) { print(e); }
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container(
        child: Column(
              children: <Widget>[
                Expanded(
                  child: _dailyData['url'] != null
                        ? FadeInImage(
                          placeholder: NetworkImage('https://imgplaceholder.com/420x320/fbf3f3/333333/fa-image'),
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(_dailyData['url'])
                        )
                        : Image(
                          image: NetworkImage('https://imgplaceholder.com/420x320/fbf3f3/333333/fa-image'),
                        )
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.grey,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.9)
                  ),
                  child: Text(_widgetText, style: TextStyle(color: Colors.white),),
                )
              ],
            )
      );
    }
}
