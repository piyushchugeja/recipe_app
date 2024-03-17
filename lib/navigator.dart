import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recipe_app/ai_recipe.dart';
import 'package:recipe_app/homepage.dart';
import 'package:recipe_app/new_recipe.dart';

final bottomNavIndexProvider = StateProvider((ref) => 0);

class NavigatorPage extends StatelessWidget {
  const NavigatorPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Recipe App",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final currentIndex = ref.watch(bottomNavIndexProvider);
          return IndexedStack(
            index: currentIndex,
            children: const [
              HomePage(),
              Center(
                child: Text(
                  "Categories page",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Favourites page",
                  style: TextStyle(fontSize: 32),
                ),
              ),
              NewRecipe(),
              AIRecipeProvider(),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        final currentIndex = ref.watch(bottomNavIndexProvider);
        return Container(
          color: const Color.fromRGBO(207, 216, 220, 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: GNav(
              backgroundColor: const Color.fromRGBO(207, 216, 220, 1),
              color: const Color.fromRGBO(167, 166, 166, 1),
              activeColor: Colors.black87,
              tabBackgroundColor: const Color.fromRGBO(0, 181, 191, 0.25),
              padding: const EdgeInsets.all(16),
              iconSize: 24,
              gap: 4,
              tabs: const [
                GButton(
                  haptic: true,
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  haptic: true,
                  icon: Icons.bookmark,
                  text: 'Types',
                ),
                GButton(
                  haptic: true,
                  icon: Icons.favorite,
                  text: 'Liked',
                ),
                GButton(
                  haptic: true,
                  icon: Icons.add_circle,
                  text: 'New',
                ),
                GButton(
                  haptic: true,
                  icon: Icons.auto_awesome,
                  text: 'Ask AI',
                )
              ],
              selectedIndex: currentIndex,
              onTabChange: (value) {
                ref
                    .read(bottomNavIndexProvider.notifier)
                    .update((state) => value);
              },
            ),
          ),
        );
      }),
    );
  }
}
