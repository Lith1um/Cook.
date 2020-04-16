class Recipe {
  final String name;
  final String imageUrl;
  final int prepTime;
  final int cookTime;
  final String cuisines;

  Recipe({this.name, this.imageUrl, this.prepTime, this.cookTime, this.cuisines});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      imageUrl: json['imageUrl'],
      prepTime: json['prepTime'],
      cookTime: json['cookTime'],
      cuisines: json['cuisines']
    );
  }

  Map<String, dynamic> toJson() => {
    'name' : name,
    'imageUrl' : imageUrl,
    'prepTime' : prepTime,
    'cookTime' : cookTime,
    'cuisines' : cuisines
  };
}
