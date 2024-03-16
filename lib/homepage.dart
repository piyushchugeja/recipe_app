import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // final recipes = [
  //   {
  //     "title": "Pasta",
  //     "imageUrl": "images/pasta.jpg",
  //     "calories": "90",
  //     "cookTime": "20 min",
  //     "cuisine": "Italian",
  //     "ingredients": [
  //       "200g pasta",
  //       "Salt to taste",
  //       "2 tbsp olive oil",
  //       "2 cloves garlic, minced",
  //       "Your favorite pasta sauce",
  //       "Grated cheese and herbs for garnish"
  //     ],
  //     "instructions": [
  //       "Boil water in a pot and add salt.",
  //       "Add pasta and cook for the instructed time.",
  //       "Drain the pasta and set aside.",
  //       "In a separate pan, heat olive oil and add minced garlic.",
  //       "Add cooked pasta to the pan and toss with desired sauce.",
  //       "Serve hot and garnish with grated cheese and herbs."
  //     ]
  //   },
  //   {
  //     "title": "Pizza",
  //     "imageUrl": "images/pizza.jpg",
  //     "calories": "120",
  //     "cookTime": "30 min",
  //     "cuisine": "Italian",
  //     "ingredients": [
  //       "Pizza dough",
  //       "Tomato sauce",
  //       "Your favorite pizza toppings (cheese, vegetables, meat)",
  //       "Flour for dusting"
  //     ],
  //     "instructions": [
  //       "Preheat your oven to the specified temperature.",
  //       "Roll out pizza dough and place it on a baking sheet.",
  //       "Spread tomato sauce evenly over the dough.",
  //       "Add your favorite toppings such as cheese, vegetables, and meat.",
  //       "Bake the pizza in the preheated oven until the crust is golden and the cheese is bubbly.",
  //       "Slice and serve hot."
  //     ]
  //   },
  //   {
  //     "title": "Burger",
  //     "imageUrl": "images/burger.jpg",
  //     "calories": "150",
  //     "cookTime": "25 min",
  //     "cuisine": "American",
  //     "ingredients": [
  //       "Ground beef",
  //       "Salt and pepper to taste",
  //       "Burger buns",
  //       "Lettuce, tomato, onion for toppings"
  //     ],
  //     "instructions": [
  //       "Preheat a grill or skillet over medium-high heat.",
  //       "Season ground beef with salt and pepper and shape into patties.",
  //       "Cook the patties for about 3-4 minutes on each side, or until desired doneness.",
  //       "Toast burger buns on the grill until lightly browned.",
  //       "Assemble the burgers with lettuce, tomato, onion, and any other desired toppings.",
  //       "Serve hot with fries or salad."
  //     ]
  //   },
  //   {
  //     "title": "Sushi",
  //     "imageUrl": "images/sushi.jpg",
  //     "calories": "100",
  //     "cookTime": "40 min",
  //     "cuisine": "Japanese",
  //     "ingredients": [
  //       "Sushi rice",
  //       "Nori sheets",
  //       "Your choice of sushi fillings (fish, vegetables, avocado)",
  //       "Soy sauce and wasabi for serving"
  //     ],
  //     "instructions": [
  //       "Cook sushi rice according to package instructions and let it cool.",
  //       "Place a sheet of nori on a bamboo sushi mat.",
  //       "Spread a thin layer of rice evenly over the nori, leaving a border at the top.",
  //       "Add your choice of fillings such as fish, vegetables, or avocado.",
  //       "Roll the sushi tightly using the bamboo mat.",
  //       "Slice the sushi roll into bite-sized pieces and serve with soy sauce and wasabi."
  //     ]
  //   }
  // ];

  final recipes = FirebaseFirestore.instance.collection('recipes');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What's in your kitchen?",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            "Let's find a recipe!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              hintText: "Search for recipes",
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
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('recipes').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot recipe = snapshot.data!.docs[index];
                    return RecipeCard(
                      title: recipe['title'],
                      imageUrl: const AssetImage('images/recipe.png'),
                      calories:
                          "${String.fromCharCode(0x00B7)}${recipe['calories']} cal",
                      cookTime: recipe['cookTime'],
                      cuisine: recipe['cuisine'],
                      ingredients: List<String>.from(recipe['ingredients']),
                      instructions: List<String>.from(recipe['instructions']),
                      typeOfFood: recipe['typeOfFood'],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
