import 'models/models.dart';

abstract class Repository {
  // TODO: Add find methods

  List<Recipe> findAllRecipes();

  Recipe findRecipeById(int id);

  List<Ingredient> findAllIngredients();

  List<Ingredient> findRecipeIngredients(int recipeId);
  // TODO: Add insert methods

  int insertRecipe(Recipe recipe);

  List<int> insertIngredients(List<Ingredient> ingredients);
  // TODO: Add delete methods

  void deleteRecipe(Recipe recipe);

  void deleteIngredient(Ingredient ingredient);

  void deleteIngredients(List<Ingredient> ingredients);

  void deleteRecipeIngredients(int recipeId);
  // TODO: Add initializing and closing methods
  Future init();

  void close();
}
