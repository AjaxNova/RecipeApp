import 'package:flutter/material.dart';
import 'package:recipie_app/utils/value_listneable.dart';
import 'package:recipie_app/view/widgets/recipie_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: allFavoRecipe,
      builder: (context, favoList, _) {
        if (favoList.isEmpty) {
          return const Center(
            child: Text(
              "No Favorite Recipies",
              style: TextStyle(color: Colors.black),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: favoList.length,
            itemBuilder: (context, index) {
              return RecipeCard(
                title: favoList[index].name,
                cookTime: favoList[index].totalTime.toString(),
                rating: favoList[index].rating.toString(),
                thumbnailUrl: favoList[index].image,
                profileUrl: favoList[index].directionsUrl,
                isFavo:
                    favoriteList.value.contains(favoList[index].directionsUrl),
              );
            },
          );
        }
      },
    ));
  }
}
