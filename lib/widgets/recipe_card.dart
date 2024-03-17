import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/recipe_details.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final AssetImage imageUrl;
  final String calories;
  final String cookTime;
  final String cuisine;
  final String typeOfFood;
  final List<String> ingredients;
  final List<String> instructions;

  const RecipeCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.calories,
    required this.cookTime,
    required this.typeOfFood,
    required this.cuisine,
    required this.ingredients,
    required this.instructions,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetails(
              title: title,
              imageUrl: imageUrl,
              calories: calories,
              cookTime: cookTime,
              cuisine: cuisine,
              ingredients: ingredients,
              instructions: instructions,
              typeOfFood: typeOfFood,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        imageUrl.assetName,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 5),
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.grey[800],
                                ),
                          ),
                          Container(height: 5),
                          Text(
                            cuisine,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.grey[500],
                                    ),
                          ),
                          Container(height: 10),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.local_fire_department,
                                color: Colors.grey[500],
                                size: 16,
                              ),
                              Container(width: 5),
                              Text(
                                calories,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.grey[500],
                                    ),
                              ),
                              Container(width: 20),
                              Icon(
                                Icons.timer,
                                color: Colors.grey[500],
                                size: 16,
                              ),
                              Container(width: 5),
                              Text(
                                cookTime,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.grey[500],
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
