import 'package:flutter/material.dart';
import 'package:recipie_app/models/recipe.dart';
import 'package:recipie_app/models/recipe_api.dart';
import 'package:recipie_app/utils/value_listneable.dart';
import 'package:recipie_app/view/widgets/recipie_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getRecipe();
  }

  Future<void> getRecipe() async {
    if (isInitiallyLoaded == false) {
      RecipeApi recipeApi = RecipeApi();
      allrecipes = await recipeApi.fetchRecipes();

      List<Recipe> dummyfavoriteRecipes = allrecipes
          .where((recipe) => favoriteList.value.contains(recipe.directionsUrl))
          .toList();
      allFavoRecipe.value.addAll(dummyfavoriteRecipes);

      setState(() {
        isLoading = false;
        isInitiallyLoaded = true;
      });
    } else {
      allrecipes = allrecipes;
    }

    // print(allrecipes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ValueListenableBuilder(
                valueListenable: favoriteList,
                builder: (context, favoList, _) {
                  return ListView.builder(
                    itemCount: allrecipes.length,
                    itemBuilder: (context, index) {
                      return RecipeCard(
                        title: allrecipes[index].name,
                        cookTime: allrecipes[index].totalTime.toString(),
                        rating: allrecipes[index].rating.toString(),
                        thumbnailUrl: allrecipes[index].image,
                        profileUrl: allrecipes[index].directionsUrl,
                        isFavo:
                            favoList.contains(allrecipes[index].directionsUrl),
                      );
                    },
                  );
                },
              )

        // ListView.builder(
        //     itemCount: allrecipes.length,
        //     itemBuilder: (context, index) {
        //       return RecipeCard(
        //         title: allrecipes[index].name,
        //         cookTime: allrecipes[index].totalTime.toString(),
        //         rating: allrecipes[index].rating.toString(),
        //         thumbnailUrl: allrecipes[index].image,
        //         profileUrl: allrecipes[index].directionsUrl,
        //       );
        //     })

        );
  }
}
