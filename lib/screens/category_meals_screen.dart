import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/meal.dart';

import '../widgets/meals_item.dart';


class CategoryMealsScreen extends StatefulWidget {

  static String route = '/category-meals';

  final List<Meal> _availableMeals;

  CategoryMealsScreen(this._availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  
  List<Meal>_categoryMeals;
  Category _category;
  bool _loadedInitData=false;

  @override
  void didChangeDependencies() {
    if(_loadedInitData==false){
      Category dCategory = ModalRoute.of(context).settings.arguments as Category;
      _category = dCategory;
    _categoryMeals =widget._availableMeals.where((meal){
      return meal.categories.contains(_category.id);
      }).toList();
    _loadedInitData =true;
    }
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {

    void _removeMeal(Meal meal){
      setState(() {
       _categoryMeals.removeWhere((meals)=>meals==meal); 
      });    
    }

    Widget _buildCupertinoNavitionBar() {
      return CupertinoNavigationBar(
          middle: Text(_category.title,
              style: Theme.of(context).appBarTheme.textTheme.title),
          backgroundColor: _category.color);
    }

    Widget _buildAppBar() {
      return AppBar(
        title:
            Text(_category.title, style: Theme.of(context).appBarTheme.textTheme.title),
        backgroundColor: _category.color,
        centerTitle: true,
      );
    }


    final Widget appBar =
        Platform.isAndroid ? _buildAppBar() : _buildCupertinoNavitionBar();

    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
        itemBuilder: (context,index){
          return MealsItem(meal:_categoryMeals[index], removeMeal: _removeMeal);
        },
        itemCount: _categoryMeals.length,
      ),
    );
  }
}
