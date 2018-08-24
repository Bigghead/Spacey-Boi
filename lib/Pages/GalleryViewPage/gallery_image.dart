import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../UI/image_container.dart';

class GalleryImage extends StatelessWidget {

  final Map data;

  GalleryImage( { @required this.data } );

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Material(
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
						      		child: new Text(data['title'],
						      			style: const TextStyle(color: Colors.white),
						      		),
						      	);
						      },
                  content: ImageContainer(data: data,),
                ),
              );
    }
}