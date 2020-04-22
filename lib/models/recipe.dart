class Recipe {
  final String name;
  final String imageUrl;
  final List<dynamic> ingredients;
  final List<dynamic> steps;
  final int prepTime;
  final int cookTime;
  final String cuisines;
  final int reviews;
  final double reviewScore;
  final int timeAdded;
  final String creator;

  Recipe({
    this.name,
    this.imageUrl,
    this.ingredients,
    this.steps,
    this.prepTime,
    this.cookTime,
    this.cuisines,
    this.reviews = 0,
    this.reviewScore = 0.0,
    this.timeAdded,
    this.creator
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      imageUrl: json['imageUrl'],
      ingredients: json['ingredients'],
      steps: json['steps'],
      prepTime: json['prepTime'],
      cookTime: json['cookTime'],
      cuisines: json['cuisines'],
      reviews: json['reviews'],
      reviewScore: json['reviewScore'],
      timeAdded: json['timeAdded'],
      creator: json['creator']
    );
  }

  Map<String, dynamic> toJson() => {
    'name' : name,
    'imageUrl' : imageUrl,
    'ingredients' : ingredients,
    'steps' : steps,
    'prepTime' : prepTime,
    'cookTime' : cookTime,
    'cuisines' : cuisines,
    'reviews' : reviews,
    'reviewScore' : reviewScore,
    'timeAdded' : timeAdded,
    'creator' : creator
  };
}
