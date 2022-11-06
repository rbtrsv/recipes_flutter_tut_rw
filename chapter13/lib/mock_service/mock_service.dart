import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:chopper/chopper.dart';

import 'package:flutter/services.dart' show rootBundle;
import '../network/model_response.dart';
import '../network/recipe_model.dart';

class MockService {
  late APIRecipeQuery _currentRecipes1;
  late APIRecipeQuery _currentRecipes2;

  Random nextRecipe = Random();
  // TODO: Add create and load methods

  void create() {
    loadRecipes();
  }

  void loadRecipes() async {
    var jsonString = await rootBundle.loadString('assets/recipes1.json');

    _currentRecipes1 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
    jsonString = await rootBundle.loadString('assets/recipes2.json');
    _currentRecipes2 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
  }

  // TODO: Add query method
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
    String query,
    int from,
    int to,
  ) {
    // Use your random field to pick a random integer, either 0 or 1.
    switch (nextRecipe.nextInt(2)) {
      case 0:
        // Wrap your APIRecipeQuery result in Success, Response and Future.
        return Future.value(
          Response(
            http.Response(
              'Dummy',
              200,
              request: null,
            ),
            Success<APIRecipeQuery>(_currentRecipes1),
          ),
        );
      case 1:
        return Future.value(
          Response(
            http.Response(
              'Dummy',
              200,
              request: null,
            ),
            Success<APIRecipeQuery>(_currentRecipes2),
          ),
        );
      default:
        return Future.value(
          Response(
            http.Response(
              'Dummy',
              200,
              request: null,
            ),
            Success<APIRecipeQuery>(_currentRecipes1),
          ),
        );
    }
  }
}
