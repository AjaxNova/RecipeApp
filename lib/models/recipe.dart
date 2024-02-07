class Recipe {
  String name;
  String image;
  String totalTime;
  double rating;
  String directionsUrl;
  Recipe(
      {required this.image,
      required this.name,
      required this.rating,
      required this.totalTime,
      required this.directionsUrl});

  factory Recipe.fromJson(
    dynamic json,
  ) {
    return Recipe(
        directionsUrl: json['attribution']['url'] as String,
        image: json['images'][0]['hostedLargeUrl'] as String,
        name: json['name'] as String,
        rating: json['rating'],
        totalTime: json['totalTime'] as String);
  }

  static List<Recipe> recipesFromSnapshot(
    List snapshots,
  ) {
    return snapshots.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }
}
