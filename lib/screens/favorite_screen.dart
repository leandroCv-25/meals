import 'package:flutter/material.dart';

import '../widgets/meals_item.dart';

import '../models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;
  final Function _function;

  FavoriteScreen(this._favoriteMeals, this._function);

  @override
  Widget build(BuildContext context) {
    if (_favoriteMeals.length == 0) {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(20),
        child: Text("You do not have favorites yet - Start to add it",
            style: Theme.of(context).textTheme.subtitle),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealsItem(meal: _favoriteMeals[index], removeMeal: _function);
        },
        itemCount: _favoriteMeals.length,
      );
    }
  }
}
