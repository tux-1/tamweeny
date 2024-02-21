class Category {
  final int id;
  final String categoryName;
  final String categoryImage;

  Category({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['categoryName'],
      categoryImage: ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'catId': id,
      'catName': categoryName,
      'categoryImage' : categoryImage,
    };
  }
}
