import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewRecipe extends StatefulWidget {
  const NewRecipe({Key? key}) : super(key: key);

  @override
  _NewRecipeState createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  final _addRecipeFormKey = GlobalKey<FormState>();
  final _recipeNameController = TextEditingController();
  final _recipeImageController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final _cuisineController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
      child: Form(
        key: _addRecipeFormKey,
        child: ListView(
          children: [
            const Text(
              "Add a new recipe",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _recipeNameController,
              decoration: const InputDecoration(
                labelText: "Recipe name",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a recipe name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _recipeImageController,
              decoration: const InputDecoration(
                labelText: "Recipe image",
                prefixIcon: Icon(Icons.image),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a recipe image';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _caloriesController,
              decoration: const InputDecoration(
                labelText: "Calories",
                prefixIcon: Icon(Icons.local_fire_department),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the calories';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cookTimeController,
              decoration: const InputDecoration(
                labelText: "Cook time",
                prefixIcon: Icon(Icons.timer),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the cook time';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cuisineController,
              decoration: const InputDecoration(
                labelText: "Cuisine",
                prefixIcon: Icon(Icons.local_dining),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the cuisine';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ingredientsController,
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Ingredients",
                prefixIcon: Icon(Icons.shopping_bag),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the ingredients';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _instructionsController,
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Instructions",
                prefixIcon: Icon(Icons.list),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the instructions';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_addRecipeFormKey.currentState!.validate()) {
                  Recipe r = Recipe(
                    name: _recipeNameController.text,
                    image: AssetImage(_recipeImageController.text),
                    calories: _caloriesController.text,
                    cookTime: _cookTimeController.text,
                    cuisine: _cuisineController.text,
                    ingredients: _ingredientsController.text.split(','),
                    instructions: _instructionsController.text.split(','),
                  );
                  var status = r.saveRecipe();
                  if (status) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Recipe added successfully'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to add recipe'),
                      ),
                    );
                  }
                  _addRecipeFormKey.currentState!.reset();
                }
              },
              child: const Text('Add recipe'),
            ),
          ],
        ),
      ),
    );
  }
}

class Recipe {
  final String name;
  AssetImage? image;
  final String calories;
  final String cookTime;
  final String cuisine;
  final List<String> ingredients;
  final List<String> instructions;

  Recipe({
    required this.name,
    required this.calories,
    required this.cookTime,
    required this.cuisine,
    required this.ingredients,
    required this.instructions,
    this.image,
  });

  @override
  String toString() {
    final String ingredientsString = ingredients.join(', ');
    final String instructionsString = instructions.join(', ');
    return 'Name: $name\nCalories: $calories\nCook time: $cookTime\nCuisine: $cuisine\nIngredients: $ingredientsString\nInstructions: $instructionsString';
  }

  bool saveRecipe() {
    try {
      FirebaseFirestore.instance.collection('recipes').add({
        'title': name,
        'calories': calories,
        'cookTime': cookTime,
        'cuisine': cuisine,
        'ingredients': ingredients,
        'instructions': instructions,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
