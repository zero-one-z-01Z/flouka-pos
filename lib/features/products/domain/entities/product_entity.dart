class Product {
  final String name;
  final String imagePath;
  final double price;
  final double? oldPrice;
  final double rating;
  bool isActive;

  Product({
    required this.name,
    required this.imagePath,
    required this.price,
    this.oldPrice,
    this.rating = 4.5,
    this.isActive = true,
  });
}
