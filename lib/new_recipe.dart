import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class NewRecipe extends StatefulWidget {
  const NewRecipe({super.key});

  @override
  _NewRecipeState createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  final _addRecipeFormKey = GlobalKey<FormState>();
  final _recipeNameController = TextEditingController();
  XFile? _recipeImageController = XFile('');
  final _imageControllerText = "Select image";
  final _cookTimeController = TextEditingController();
  double _sliderValue = 20;
  String? _foodType = 'Vegetarian';
  final _cuisineController = TextEditingController(text: 'Indian');
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  final List<String> _cuisines = [
    'Indian',
    'Chinese',
    'Italian',
    'Mexican',
    'American',
    'Japanese',
    'Thai',
    'Belgian',
    'Greek',
  ];
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
            OutlinedButton.icon(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                setState(() {
                  _recipeImageController = image;
                });
              },
              icon: const Icon(Icons.upload_file),
              label: Text(
                _recipeImageController == null
                    ? _imageControllerText
                    : _recipeImageController?.name ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(vertical: 16),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
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
            // TextFormField(
            //   controller: _cuisineController,
            //   decoration: const InputDecoration(
            //     labelText: "Cuisine",
            //     prefixIcon: Icon(Icons.local_dining),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(16),
            //       ),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(16),
            //       ),
            //     ),
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter the cuisine';
            //     }
            //     return null;
            //   },
            // ),
            // Use dropdown to ask for cuisine
            DropdownButtonFormField<String>(
              value: _cuisineController.text,
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
              items: _cuisines.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _cuisineController.text = value!;
                });
              },
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
            const Text("Calories"),
            Slider(
              value: _sliderValue.toDouble(),
              min: 0,
              max: 100,
              divisions: 100,
              label: _sliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Radio(
                  value: 'Vegetarian',
                  groupValue: _foodType,
                  onChanged: (value) {
                    setState(() {
                      _foodType = value;
                    });
                  },
                ),
                const Text('Vegetarian'),
                Radio(
                  value: 'Non Vegetarian',
                  groupValue: _foodType,
                  onChanged: (value) {
                    setState(() {
                      _foodType = value;
                    });
                  },
                ),
                const Text('Non Vegetarian'),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_addRecipeFormKey.currentState!.validate()) {
                  Recipe r = Recipe(
                    name: _recipeNameController.text,
                    image: _recipeImageController,
                    calories: _sliderValue.round().toString(),
                    cookTime: _cookTimeController.text,
                    cuisine: _cuisineController.text,
                    typeOfFood: _foodType!,
                    ingredients: _ingredientsController.text.split('\n'),
                    instructions: _instructionsController.text.split('\n'),
                  );
                  var status = r.saveRecipe();
                  if (status) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Recipe added successfully"),
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
  XFile? image;
  final String calories;
  final String cookTime;
  final String cuisine;
  final String typeOfFood;
  final List<String> ingredients;
  final List<String> instructions;

  Recipe({
    required this.name,
    required this.calories,
    required this.cookTime,
    required this.cuisine,
    required this.ingredients,
    required this.instructions,
    required this.typeOfFood,
    required this.image,
  });

  @override
  String toString() {
    final String ingredientsString = ingredients.join(', ');
    final String instructionsString = instructions.join(', ');
    return 'Name: $name\nCalories: $calories\nCook time: $cookTime\nCuisine: $cuisine\nIngredients: $ingredientsString\nInstructions: $instructionsString';
  }

  bool saveRecipe() {
    try {
      File imageFile = File(image!.path);
      FirebaseFirestore.instance.collection('recipes').add({
        'title': name,
        'calories': calories,
        'cookTime': cookTime,
        'cuisine': cuisine,
        'image': imageFile,
        'ingredients': ingredients,
        'instructions': instructions,
        'typeOfFood': typeOfFood,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
