class CartItem {
  final String name;
  final String imagePath;
  final Map<String, double> pricesBySize;
  final String? description;
  final String selectedSize;
  int quantity;

  CartItem({
    required this.name,
    required this.imagePath,
    required this.pricesBySize,
    required this.selectedSize,
    this.description,
    this.quantity = 1,
  });

  double get totalPrice => (pricesBySize[selectedSize] ?? 0) * quantity;
}
