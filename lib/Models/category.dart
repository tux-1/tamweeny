
class Category {
  final int catId;
  final String catName;

  Category({
    required this.catId,
    required this.catName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      catId: json['catId'],
      catName: json['catName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'catId': catId,
      'catName': catName,
    };
  }
}