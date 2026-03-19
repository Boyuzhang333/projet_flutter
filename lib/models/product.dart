class Product {
  const Product({
    required this.id,
    required this.title,
    required this.size,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String size;
  final double price;
  final String imageUrl;
}
