class ProductModel {
  String name;
  String description;
  double price;
  String category;
  bool isAvailable;
  String nameAr;
  String nameEn;
  String descriptionAr;
  String descriptionEn;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.isAvailable,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "category": category,
      "isAvailable": isAvailable,
      'name_ar': nameAr,
      'name_en': nameEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
    };
  }
}
