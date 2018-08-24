import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {

  final Map data;

  ImageContainer( { @required this.data } );

  @override
    Widget build(BuildContext context) {
      
      // TODO: implement build
      return Container(
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
            : Image(image: NetworkImage('https://imgplaceholder.com/420x320/f9ebe0/4c4747/glyphicon-facetime-video'),),
      );
    }
}