import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

import './category_Screen.dart';
import './favorite_screen.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;
  final Function toggleFavorite;

  TabsScreen(this._favoriteMeals, this.toggleFavorite);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> _pages = [
      {
        "page": CategoryScreen(),
        "title": "Categories of Meal",
      },
      {
        "page": FavoriteScreen(widget._favoriteMeals,widget.toggleFavorite),
        "title": "My Favorites Meals",
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]["title"],
            style: Theme.of(context).appBarTheme.textTheme.title),
        backgroundColor: Theme.of(context).appBarTheme.color,
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _selectPage,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("Category", style: Theme.of(context).textTheme.title),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Favorite", style: Theme.of(context).textTheme.title),
          ),
        ],
      ),
    );
  }
}
