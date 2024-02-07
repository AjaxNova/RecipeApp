import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipie_app/models/recipe.dart';
import 'package:recipie_app/models/recipe_api.dart';
import 'package:recipie_app/utils/value_listneable.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String rating;
  final String cookTime;
  final String thumbnailUrl;
  final String profileUrl;
  final bool isFavo;

  const RecipeCard(
      {super.key,
      required this.title,
      required this.cookTime,
      required this.rating,
      required this.thumbnailUrl,
      required this.profileUrl,
      required this.isFavo});
  @override
  Widget build(BuildContext context) {
    void showConfirmationDialog(BuildContext context) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,

        title: "Confirm",
        text: "Do you want to redirect to the website?",
        confirmBtnText: "Yes",
        cancelBtnText: "No",
        textTextStyle: const TextStyle(
            color: Colors.black), // Change the text color to black
        onConfirmBtnTap: () {
          _launchRecipeProfile(profileUrl);
        },
      );
    }

    return GestureDetector(
      onTap: () {
        showConfirmationDialog(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(
                0.0,
                10.0,
              ),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ],
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35),
              BlendMode.multiply,
            ),
            image: NetworkImage(thumbnailUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () async {
                    addOrRemoveFromFavorites(
                        profileUrl,
                        Recipe(
                            image: thumbnailUrl,
                            name: title,
                            rating: double.parse(rating),
                            totalTime: cookTime,
                            directionsUrl: profileUrl));
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isFavo ? Colors.red : Colors.white,
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        const SizedBox(width: 7),
                        Text(rating),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        const SizedBox(width: 7),
                        Text(cookTime),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchRecipeProfile(String profileUrl) {
    RecipeApi recipeApi = RecipeApi();
    recipeApi.lauchUrl(profileUrl);
  }

  void addOrRemoveFromFavorite(String url) async {
    var favoBox = await Hive.openBox('recipeApp');
    if (favoBox.values.contains(url)) {
      await favoBox.delete(url);
    } else {
      await favoBox.add(url);
    }
  }
}
