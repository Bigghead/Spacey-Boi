import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../Pages/Homepage/homepage.dart';
import '../Pages/GalleryViewPage/gallery_view_page.dart';
import '../Pages/FavoritePage/favorite_page.dart';

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
                                  context: context,
                                  initialDate: new DateTime.now(),
                                  firstDate:
                                      new DateTime.now().subtract(new Duration(days: 30)),
                                  lastDate: new DateTime.now().add(new Duration(days: 30)),
                            ).then((date) => print(DateFormat('yyyy-MM-dd').format(date)));
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