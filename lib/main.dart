import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipie_app/utils/value_listneable.dart';
import 'package:recipie_app/view/bottom_nav.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox<String>('recipeApp');
  Box<String> recipeAppBox = Hive.box<String>('recipeApp');
  List<String> allFav = recipeAppBox.values.toList();

  favoriteList.value.addAll(allFav);

  runApp(const MyRecipeApp());
}

class MyRecipeApp extends StatelessWidget {
  const MyRecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food4u",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        primarySwatch: Colors.lightBlue,
        primaryColor: Colors.white,
      ),
      home: const BottomScreen(),
    );
  }
}
