import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

class FilterScreen extends StatefulWidget {
  static const route = "/filter-screen";

  final Function saveFilters;
  final Map<String,bool> currentFilters;

  FilterScreen(this.currentFilters, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;

  @override
  void initState(){
    _glutenFree = widget.currentFilters["gluten"];
    _vegan = widget.currentFilters["vegan"];
    _vegetarian = widget.currentFilters["vegetarian"];
    _lactoseFree = widget.currentFilters["lactose"];
    super.initState();
  }

  Widget _buildSwitchListTile({BuildContext context, String title,bool variable,Function function}) {
    return SwitchListTile.adaptive(
      title: Text(title, style: Theme.of(context).textTheme.subtitle),
      value: variable,
      subtitle: Text("Only inclyde $title meals",
          style: Theme.of(context).textTheme.body1),
      onChanged: function,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",
            style: Theme.of(context).appBarTheme.textTheme.title),
        backgroundColor: Theme.of(context).appBarTheme.color,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save),onPressed: (){
            final Map<String,bool> _selectedFilters ={
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            };
            widget.saveFilters(_selectedFilters);
            },),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(context: context, title: "Gluten-Free",variable: _glutenFree, function: (newValue){
                  setState(() {
                   _glutenFree=newValue; 
                  });
                }),
                _buildSwitchListTile(context: context, title: "Lactose-Free",variable: _lactoseFree, function: (newValue){
                  setState(() {
                   _lactoseFree=newValue; 
                  });
                }),
                _buildSwitchListTile(context: context, title: "Vegan",variable: _vegan, function: (newValue){
                  setState(() {
                   _vegan=newValue; 
                  });
                }),
                _buildSwitchListTile(context: context, title: "Vegetarian",variable: _vegetarian, function: (newValue){
                  setState(() {
                   _vegetarian=newValue; 
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
