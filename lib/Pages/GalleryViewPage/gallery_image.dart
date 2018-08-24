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
						      	return Container(
						      		height: 50.0,
						      		color: Colors.black.withOpacity(0.35),
						      		alignment: Alignment.centerLeft,
						      		child: Center(
                        child: Text(data['title'],
						      			style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontFamily: 'Oswald'
                        ),
						      		),
                      ),
						      	);
						      },
                  content: ImageContainer(data: data,),
                ),
              );
    }
}