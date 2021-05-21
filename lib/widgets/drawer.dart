import 'package:flutter/material.dart';

import '../screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  
  Widget _buildTile(BuildContext context, String title, IconData icon, Function function){
    return Column(children: <Widget>[
      Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              icon,
              size: 26,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontFamily:"RobotoCondesed",
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            onTap: function,
          ),
          Divider(
            thickness: 1,
          ),
    ],);
  }
  
  @override
  Widget build(BuildContext context) {
    final MediaQueryData _media = MediaQuery.of(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).accentColor,
            height: _media.size.height / 5,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                vertical: _media.size.height / 20,
                horizontal: _media.size.width / 10),
            alignment: Alignment.centerLeft,
            child: Text("Cooking Up!",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Raleway',
                    fontSize: 30,
                    color: Theme.of(context).primaryColor)),
          ),
          _buildTile(context, "Meals", Icons.restaurant_menu, (){
            Navigator.of(context).pushReplacementNamed("/");
          }),
          _buildTile(context, "Settings", Icons.settings,(){
            Navigator.of(context).pushReplacementNamed(FilterScreen.route);
          }),
        ],
      ),
    );
  }
}
