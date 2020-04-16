class Recipe {
  final String name;
  final String imageUrl;
  final int prepTime;
  final int cookTime;
  final String cuisines;
  final int reviews;
  final double reviewScore;

  Recipe({
    this.name,
    this.imageUrl, 
    this.prepTime,
    this.cookTime,
    this.cuisines,
    this.reviews = 0,
    this.reviewScore = 0.0
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      imageUrl: json['imageUrl'],
      prepTime: json['prepTime'],
      cookTime: json['cookTime'],
      cuisines: json['cuisines'],
      reviews: json['reviews'],
      reviewScore: json['reviewScore']
    );
  }

  Map<String, dynamic> toJson() => {
    'name' : name,
    'imageUrl' : imageUrl,
    'prepTime' : prepTime,
    'cookTime' : cookTime,
    'cuisines' : cuisines,
    'reviews' : reviews,
    'reviewScore' : reviewScore
  };
}
