import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../keys.dart';


class DailyPic extends StatefulWidget {

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _DailyPicState();
    }
}


class _DailyPicState extends State<DailyPic> {

  final String _url = 'https://api.nasa.gov/planetary/apod?api_key=${api_key}';
  Map _dailyData = {};


  @override
  initState(){
    _getDailyData();
    super.initState();
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
        // constraints: BoxConstraints(maxHeight: 500.0),
        child: _dailyData['url'] != null 
            ? Image(
              fit: BoxFit.cover,
              image: NetworkImage(_dailyData['url'])
            )
            : Text('Meep')
      );
    }
}
