import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class Recipe {
  final String label;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final int prepTime;
  final int cookTime;
  final int servings;
  final String category;

  void addIngredient(String ingredient) {
    ingredients.add(ingredient);
  }
  void addInstruction(String instruction) {
    instructions.add(instruction);
  }
  void removeIngredient(String ingredient) {
    ingredients.remove(ingredient);
  }
  void removeInstruction(String instruction) {
    instructions.remove(instruction);
  }
  int getTotalTime() {
    return prepTime + cookTime;
  }
  String displayRecipe() {
    return '''Recipe: $label
Category: $category
Prep Time: $prepTime minutes
Cook Time: $cookTime minutes
Servings: $servings
Ingredients:\n${ingredients.join('\n')}
Instructions:\n${instructions.join('\n')}''';
  }

  const Recipe({
    required this.label,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.category,
  });
}

List<Recipe> sampleRecipes = [
  Recipe(
    label: 'Spaghetti Bolognese',
    imageUrl: 'https://example.com/spaghetti.jpg',
    ingredients: ['200g spaghetti', '100g ground beef', '1 onion', '2 cloves garlic', '400g canned tomatoes', 'Salt', 'Pepper'],
    instructions: ['Cook spaghetti according to package instructions.', 'Sauté onion and garlic until translucent.', 'Add ground beef and cook until browned.', 'Add canned tomatoes and simmer for 20 minutes.', 'Season with salt and pepper to taste.'],
    prepTime: 15,
    cookTime: 30,
    servings: 4,
    category: 'Main Course',
  ),
  Recipe(
    label: 'Chocolate Chip Cookies',
    imageUrl: 'https://example.com/cookies.jpg',
    ingredients: ['2 cups flour', '1 cup sugar', '1 cup chocolate chips', '1/2 cup butter', '1 egg', '1 tsp vanilla extract', '1 tsp baking soda', '1/2 tsp salt'],
    instructions: ['Preheat oven to 350°F (175°C).', 'Cream together butter and sugar.', 'Beat in egg and vanilla extract.', 'In a separate bowl, combine flour, baking soda, and salt.', 'Gradually add dry ingredients to wet ingredients.', 'Stir in chocolate chips.', 'Drop by spoonfuls onto a baking sheet and bake for 10-12 minutes.'],
    prepTime: 20,
    cookTime: 12,
    servings: 24,
    category: 'Dessert',
  ),
  Recipe(
    label: 'Chicken Caesar Salad',
    imageUrl: 'https://example.com/caesar.jpg',
    ingredients: ['2 chicken breasts', '1 head romaine lettuce', '1/4 cup croutons', '1/2 cup Caesar dressing', '1/2 cup Parmesan cheese'],
    instructions: ['Grill chicken breasts until cooked through and slice.', 'Wash and chop romaine lettuce.', 'In a large bowl, toss lettuce with Caesar dressing.', 'Top with sliced chicken, croutons, and Parmesan cheese.'],
    prepTime: 15,
    cookTime: 10,
    servings: 4,
    category: 'Appetizer',
  ),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RecipeListScreen(),
    );
  }
}

class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final Set<int> _expandedIndices = {};

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Book'),
      ),
      body: Center(
        child: ListView.builder(
        itemCount: sampleRecipes.length,
        itemBuilder: (BuildContext context, int index) {      
          final bool isExpanded = _expandedIndices.contains(index);
          final String mainLabel = isExpanded
              ? sampleRecipes[index].displayRecipe()
              : 'Recipe: ${sampleRecipes[index].label}';
          return GestureDetector(
              onTap: () {
                setState(() {
                  if (isExpanded) {
                    _expandedIndices.remove(index);
                  } else {
                    _expandedIndices.add(index);
                  }
                });
              },
              child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
                mainLabel,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ))
    );
  }
}