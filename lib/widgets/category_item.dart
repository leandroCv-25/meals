import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';

import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({this.category});

  void selectCategory(BuildContext context, Category _category) {
    Navigator.of(context).pushNamed(CategoryMealsScreen.route, arguments: _category);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectCategory(context, category);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [category.color.withOpacity(0.7), category.color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
