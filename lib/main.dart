import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Recipe {
  final String label;
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
    ingredients: ['200g spaghetti', '100g ground beef', '1 onion', '2 cloves garlic', '400g canned tomatoes', 'Salt', 'Pepper'],
    instructions: ['Cook spaghetti according to package instructions.', 'Sauté onion and garlic until translucent.', 'Add ground beef and cook until browned.', 'Add canned tomatoes and simmer for 20 minutes.', 'Season with salt and pepper to taste.'],
    prepTime: 15,
    cookTime: 30,
    servings: 4,
    category: 'Main Course',
  ),
  Recipe(
    label: 'Chocolate Chip Cookies',
    ingredients: ['2 cups flour', '1 cup sugar', '1 cup chocolate chips', '1/2 cup butter', '1 egg', '1 tsp vanilla extract', '1 tsp baking soda', '1/2 tsp salt'],
    instructions: ['Preheat oven to 350°F (175°C).', 'Cream together butter and sugar.', 'Beat in egg and vanilla extract.', 'In a separate bowl, combine flour, baking soda, and salt.', 'Gradually add dry ingredients to wet ingredients.', 'Stir in chocolate chips.', 'Drop by spoonfuls onto a baking sheet and bake for 10-12 minutes.'],
    prepTime: 20,
    cookTime: 12,
    servings: 24,
    category: 'Dessert',
  ),
  Recipe(
    label: 'Chicken Caesar Salad',
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
      routes: <String, WidgetBuilder>{
        'NewRecipe': (BuildContext context) => NewRecipeScreen(),
      },
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Book'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewRecipeScreen()));
            },
            child: Icon(Icons.add),
          ),
          Expanded(
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewRecipeScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prepTimeController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final TextEditingController _servingsController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Recipe',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 30, 30, 30),
          ),
        ),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Recipe Name',
              ),
            ),
            TextField(
              controller: _prepTimeController,
              decoration: InputDecoration(
                labelText: 'Prep Time (minutes)',
              ),
            ),
            TextField(
              controller: _cookTimeController,
              decoration: InputDecoration(
                labelText: 'Cook Time (minutes)',
              ),
            ),
            TextField(
              controller: _servingsController,
              decoration: InputDecoration(
                labelText: 'Servings',
              ),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
            TextField(
              controller: _ingredientsController,
              decoration: InputDecoration(
                labelText: 'Ingredients (comma separated)',
              ),
            ),
            TextField(
              controller: _instructionsController,
              decoration: InputDecoration(
                labelText: 'Instructions (comma separated)',
              ),
            ),
            ElevatedButton(onPressed: (){
            submitData();},
             child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
  void dispose() {
    _nameController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    _servingsController.dispose();
    _categoryController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
  }
  void submitData() {
  String name = _nameController.text;
  int prepTime = int.parse(_prepTimeController.text);
  int cookTime = int.parse(_cookTimeController.text);
  int servings = int.parse(_servingsController.text);
  String category = _categoryController.text;
  List<String> ingredients = _ingredientsController.text.split(',').map((e) => e.trim()).toList();
  List<String> instructions = _instructionsController.text.split(',').map((e) => e.trim()).toList();

  Recipe newRecipe = Recipe(
    label: name,
    ingredients: ingredients,
    instructions: instructions,
    prepTime: prepTime,
    cookTime: cookTime,
    servings: servings,
    category: category,
  );

  sampleRecipes.add(newRecipe);
}
}
