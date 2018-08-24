import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import './Store/gallery_image_store.dart';

import './Pages/Homepage/homepage.dart';

void main() {
  debugPaintSizeEnabled=true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return ScopedModel<GalleryData>(
        model: GalleryData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
        routes: {
          '/': ( BuildContext context ) => HomePage(),
        },
      ),);
    }
}
