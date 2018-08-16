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
                )
              ],
            ),
          ),
        ),
      );
    }
}