class Recipe {
  final String name;
  final String imageUrl;

  Recipe({this.name, this.imageUrl});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      imageUrl: json['imageUrl']
    );
  }

  Map<String, dynamic> toJson() => {
    'name' : name,
    'imageUrl' : imageUrl
  };
}
