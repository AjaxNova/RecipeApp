import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipie_app/models/recipe.dart';

ValueNotifier<List<String>> favoriteList = ValueNotifier<List<String>>([]);
ValueNotifier<List<Recipe>> allFavoRecipe = ValueNotifier<List<Recipe>>([]);
bool isInitiallyLoaded = false;
bool isLoading = true;
List<Recipe> allrecipes = [];

// addToFavoList(String url, Recipe model) async {
//   // var favBox = await Hive.openBox<String>('recipeApp');

//   // if (favBox.values.contains(url)) {
//   //   await favBox.delete(url);
//   //   allFavoRecipe.value.removeWhere((recipe) => recipe.directionsUrl == url);
//   //   favoriteList.value.remove(url);
//   //   allFavoRecipe.notifyListeners();
//   //   favoriteList.notifyListeners();
//   // } else {
//   //   await favBox.add(url);
//   //   favoriteList.value.add(url);
//   //   allFavoRecipe.value.add(model);
//   //   allFavoRecipe.notifyListeners();
//   //   favoriteList.notifyListeners();
//   // }

//   // log("called");
//   // if (favoriteList.value.contains(url)) {
//   //   var allFavs = await Hive.openBox<String>('recipeApp');
//   //   await allFavs.delete(url);
//   //   allFavoRecipe.value.removeWhere((recipe) => recipe.directionsUrl == url);
//   //   favoriteList.value.remove(url);

//   //   allFavoRecipe.notifyListeners();
//   //   favoriteList.notifyListeners();

//   //   log("removed");
//   //   log(allFavs.values.toList().toString());
//   // } else {
//   //   var box = await Hive.openBox<String>('recipeApp');
//   //   await box.add(url);
//   //   favoriteList.value.add(url);
//   //   allFavoRecipe.value.add(model);
//   //   allFavoRecipe.notifyListeners();
//   //   favoriteList.notifyListeners();
//   //   log("added");
//   // }
// }

Future<void> addOrRemoveFromFavorites(String url, Recipe model) async {
  try {
    var box = await Hive.openBox<String>('recipeApp');

    if (box.containsKey(url)) {
      await box.delete(url);
      allFavoRecipe.value.removeWhere((recipe) => recipe.directionsUrl == url);
      favoriteList.value.remove(url);
      allFavoRecipe.notifyListeners();
      favoriteList.notifyListeners();
    } else {
      await box.put(url, url);
      favoriteList.value.add(url);
      allFavoRecipe.value.add(model);
      allFavoRecipe.notifyListeners();
      favoriteList.notifyListeners();
    }
  } catch (error) {
    log('Error: $error');
  }
}
