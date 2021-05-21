import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../screens/meal_screen_detail.dart';

class MealsItem extends StatelessWidget {
  final Meal meal;
  final Function removeMeal;

  const MealsItem({@required this.meal, @required this.removeMeal});

  void _selectMeal(BuildContext context, Meal _meal) {
    Navigator.of(context)
        .pushNamed(MealScreenDetail.route, arguments: _meal)
        .then((result) {
      if (result != null) {
        return removeMeal(result);
      }
    });
  }

  String get complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return "Simple";
        break;
      case Complexity.Challenging:
        return "Challenging";
        break;
      case Complexity.Hard:
        return "Hard";
        break;
      default:
        return "Unknowm";
        break;
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return "Affordable";
        break;
      case Affordability.Pricey:
        return "Pricey";
        break;
      case Affordability.Luxurious:
        return "Luxurious";
        break;
      default:
        return "Unknowm";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return InkWell(
      onTap: () => _selectMeal(context, meal),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    height: media.size.height / 3 - media.padding.top,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                        color: Colors.black38,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        width: media.size.height / 3 - media.padding.top - 10,
                        child: Text(
                          meal.title,
                          style: Theme.of(context).appBarTheme.textTheme.title,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )))
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FittedBox(
                      child:Row(children: <Widget>[
                      Icon(
                        Icons.schedule,
                      ),
                      SizedBox(width: 6),
                      Text("${meal.duration} min", style: Theme.of(context).textTheme.body2,),
                    ]),
                    ),
                  ),
                  Expanded(
                    child:  FittedBox(
                      child:Row(children: <Widget>[
                          Icon(
                            Icons.work,
                          ),
                          SizedBox(width: 6),
                          Text(complexityText,style:Theme.of(context).textTheme.body2,),
                        ]),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      child:Row(children: <Widget>[
                      Icon(
                        Icons.attach_money,
                      ),
                      SizedBox(width: 6),
                      Text(affordabilityText,style:Theme.of(context).textTheme.body2,),
                    ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
