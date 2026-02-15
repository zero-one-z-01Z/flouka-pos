class Product {
  final String name;
  final String imagePath;
  final List<String> imagePaths;
  final double price;
  final double? oldPrice;
  final double rating;
  final String description;
  final String storeName;
  bool isActive;

  Product({
    required this.name,
    required this.imagePath,
    required this.price,
    this.oldPrice,
    this.rating = 4.5,
    required this.description,
    required this.storeName,
    this.imagePaths = const [],
    this.isActive = true,
  });
}
