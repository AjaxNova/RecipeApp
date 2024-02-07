import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:recipie_app/models/recipe.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeApi {
  final String url =
      'https://yummly2.p.rapidapi.com/feeds/list?limit=24&start=0&tag=list.recipe.popular';
  final Map<String, String> headers = {
    'X-RapidAPI-Key': 'cc715f433cmshfa1d8b32529836ap18592bjsnd27723ece1d0',
    'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
  };

  Future<List<Recipe>> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      Map data = jsonDecode(response.body);

      List temp = [];

      for (var i in data['feed']) {
        temp.add(i['content']['details']);
      }

      return Recipe.recipesFromSnapshot(temp);
    } catch (error) {
      log(error.toString());

      return [];
    }
  }

  void lauchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launch(url);
    }
  }
}
