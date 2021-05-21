import 'package:flutter/material.dart';

import './screens/category_meals_screen.dart';
import './screens/meal_screen_detail.dart';
import './screens/tabs_screen.dart';
import './screens/filter_screen.dart';

import './models/meal.dart';

import './dummy-data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

List<Meal> _availableMeals = DUMMY_MEALS;
List<Meal> _favoriteMeals = [];  
  
void _toggleFavorite(Meal _meal){
 final existingIndex = _favoriteMeals.indexWhere((meal)=> meal.id == _meal.id);
 if(existingIndex >= 0){
   setState((){
     _favoriteMeals.removeAt(existingIndex);
   });
 }
 if(existingIndex < 0){
   setState((){
     _favoriteMeals.add(_meal);
   });
  }
}
  
  
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian':false,
  };

  void _setFilters(Map<String, bool> filterData){
    setState(() {
     _filters = filterData; 

     _availableMeals = DUMMY_MEALS.where((meal){
       if(_filters['gluten']&& !meal.isGlutenFree){
         return false;
       }
       if(_filters['lactose']&& !meal.isLactoseFree){
         return false;
       }
       if(_filters['vegan']&& !meal.isVegan){
         return false;
       }
       if(_filters['vegetarian']&& !meal.isVegetarian){
         return false;
       }
       return true;
     }).toList();
    });
 }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.blueGrey,
        fontFamily: "Raleway",
        textTheme: TextTheme(
          title: TextStyle(
              color: Colors.white, 
              fontSize: 22, 
              fontWeight: FontWeight.bold,
              ),
          subtitle: TextStyle(
              color: Colors.red, 
              fontSize: 22, 
              fontWeight: FontWeight.bold,
              ),
          body1: TextStyle(
              color: Colors.white, 
              fontSize: 18, 
              fontWeight: FontWeight.normal,
              ),
          body2: TextStyle(
              color: Colors.red, 
              fontSize: 12, 
              fontWeight: FontWeight.normal,
              ),
        ),
        appBarTheme: AppBarTheme(
            color: Colors.red,
            textTheme: TextTheme(
                title: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              fontFamily: "RobotoCondensed"
            ))),
      ),
      debugShowCheckedModeBanner: false,
      //home: CategoryScreen(),
      initialRoute: '/', //Default but for sure
      routes: {
        '/':               (context) => TabsScreen(_favoriteMeals,_toggleFavorite),
        CategoryMealsScreen.route: (context) => CategoryMealsScreen(_availableMeals),
        MealScreenDetail.route: (context) => MealScreenDetail(_toggleFavorite,_favoriteMeals),
        FilterScreen.route: (context) => FilterScreen(_filters,_setFilters),
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx)=> TabsScreen(_favoriteMeals,_toggleFavorite));
        },
    );
  }
}
