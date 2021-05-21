import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealScreenDetail extends StatelessWidget {
  static const String route = "/detail-meal";

  final Function _toggleFavorite;
  final List<Meal> _favoriteMeals;
  

  MealScreenDetail(this._toggleFavorite,this._favoriteMeals);

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Text(title, style: Theme.of(context).textTheme.subtitle),
    );
  }

  Widget _buildContainer({MediaQueryData media, Widget child}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      height: (media.size.height - 40) * 0.3,
      width: media.size.width - 50,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Meal _meal = ModalRoute.of(context).settings.arguments as Meal;
    final bool _isfavorite = _favoriteMeals.any((meal)=> meal.id == _meal.id);

    final Widget appbar = Platform.isAndroid
        ? AppBar(
            title: Text(_meal.title,
                style: Theme.of(context).appBarTheme.textTheme.title),
            backgroundColor: Theme.of(context).appBarTheme.color,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: _isfavorite?Icon(Icons.favorite,):Icon(Icons.favorite_border),
                iconSize: 32,
                tooltip: _isfavorite?"delete from favorites":"Add from favorites",
                onPressed: (){_toggleFavorite(_meal);},
              ),
            ],
          )
        : CupertinoNavigationBar(
            middle: Text(_meal.title,
                style: Theme.of(context).appBarTheme.textTheme.title),
            backgroundColor: Theme.of(context).appBarTheme.color,
          );

    final MediaQueryData _media = MediaQuery.of(context);

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: (_media.size.height - 40) * 0.4,
              width: double.maxFinite,
              child: Image.network(
                _meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, "Ingredients"),
            _buildContainer(
              media: _media,
              child: ListView.builder(
                itemCount: _meal.ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    color: Theme.of(context).accentColor,
                    child: Text(_meal.ingredients[index],
                        style: Theme.of(context).textTheme.body1),
                  );
                },
              ),
            ),
            _buildSectionTitle(context, "Steps"),
            _buildContainer(
              media: _media,
              child: ListView.builder(
                itemCount: _meal.steps.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            "#${index + 1}",
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        title: Text(
                          _meal.steps[index],
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: (){
          Navigator.of(context).pop(_meal);
        },
      ),
    );
  }
}
