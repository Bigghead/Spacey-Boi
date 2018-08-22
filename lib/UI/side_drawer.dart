import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {

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
                  margin: EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.home, color: Colors.white,),
                          SizedBox(width: 5.0,),
                          Text('Home', style: TextStyle(color: Colors.white),)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
}