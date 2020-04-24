class Recipe {
  final String name;
  final String description;
  final String imageUrl;
  final String difficulty;
  final List<dynamic> ingredients;
  final List<dynamic> steps;
  final int prepTime;
  final int cookTime;
  final String tags;
  final int reviews;
  final double reviewScore;
  final int timeAdded;
  final String creator;
  final List<dynamic> favourites;

  Recipe({
    this.name,
    this.description,
    this.imageUrl,
    this.difficulty,
    this.ingredients,
    this.steps,
    this.prepTime,
    this.cookTime,
    this.tags,
    this.reviews = 0,
    this.reviewScore = 0.0,
    this.timeAdded,
    this.creator,
    this.favourites
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      difficulty: json['difficulty'],
      ingredients: json['ingredients'],
      steps: json['steps'],
      prepTime: json['prepTime'],
      cookTime: json['cookTime'],
      tags: json['tags'],
      reviews: json['reviews'],
      reviewScore: json['reviewScore'],
      timeAdded: json['timeAdded'],
      creator: json['creator'],
      favourites: json['favourites']
    );
  }

  Map<String, dynamic> toJson() => {
    'name' : name,
    'description' : description,
    'imageUrl' : imageUrl,
    'difficulty' : difficulty,
    'ingredients' : ingredients,
    'steps' : steps,
    'prepTime' : prepTime,
    'cookTime' : cookTime,
    'tags' : tags,
    'reviews' : reviews,
    'reviewScore' : reviewScore,
    'timeAdded' : timeAdded,
    'creator' : creator,
    'favourites' : favourites
  };
}
