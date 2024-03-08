class Category {
  final int id;
  final String categoryName;
  final String categoryImage;
  final String categoryIcon;

  Category({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryIcon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['categoryName'].toString(),
      categoryImage: json['categoryImage'].toString(),
      categoryIcon: json['categoryIcon'].toString(),
    );
  }
}
