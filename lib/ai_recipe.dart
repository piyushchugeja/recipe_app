import 'package:flutter/material.dart';
import 'package:recipe_app/api_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recipe_app/widgets/recipe_details.dart';

class AIRecipeProvider extends StatefulWidget {
  const AIRecipeProvider({super.key});
  @override
  State<AIRecipeProvider> createState() => _AIRecipeProviderState();
}

class _AIRecipeProviderState extends State<AIRecipeProvider> {
  final _ingredientsController = TextEditingController();
  var _loading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('images/ai_bg.png'),
                    fit: BoxFit.cover,
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Type in your ingredients and AI will suggest you what to make!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _ingredientsController,
                    decoration: const InputDecoration(
                      hintText: "tomato, onion, garlic, cheese, etc.",
                      label: Text("Your ingredients"),
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
                  ),
                ),
                const SizedBox(width: 16),
                // Add icon button
                IconButton(
                  icon: _loading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.send),
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                  onPressed: () {
                    getRecipe(_ingredientsController.text);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void getRecipe(String ingredients) async {
    const url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${GeminiApiKey.apiKey}';
    final header = {'Content-Type': 'application/json'};
    final message =
        'Suggest a recipe with $ingredients. Return the following things: title, ingredients, instructions, type of food (vegetarian or non vegetarian), cuisine, cook time, calories in a JSON format.';
    var query = {
      "contents": [
        {
          "parts": [
            {"text": message}
          ]
        }
      ]
    };
    setState(() {
      _loading = true;
    });
    final response = await http.post(
      Uri.parse(url),
      headers: header,
      body: json.encode(query),
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      var recipe = result['candidates'][0]['content']['parts'][0]['text'];
      var firstIndex = recipe.indexOf("{");
      var lastIndex = recipe.lastIndexOf("}");
      recipe = recipe.substring(firstIndex, lastIndex + 1);
      var recipeJson = json.decode(recipe);
      print(recipeJson);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetails(
            title: recipeJson['title'],
            imageUrl: AssetImage('images/ai_recipe.png'),
            calories: recipeJson['calories'].toString() + " cal",
            cookTime: recipeJson['cookTime'],
            cuisine: recipeJson['cuisine'],
            ingredients: List<String>.from(recipeJson['ingredients']),
            instructions: List<String>.from(recipeJson['instructions']),
            typeOfFood: recipeJson['type'],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: ${response.statusCode}",
          ),
        ),
      );
    }
    setState(() {
      _ingredientsController.clear();
      _loading = false;
    });
  }
}
