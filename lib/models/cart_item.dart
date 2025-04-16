class CartItem {
  final String id;
  final String productId;
  final String name;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  static CartItem fromJson(item) {
    return CartItem(
      id: item['id'],
      productId: item['productId'],
      name: item['name'],
      quantity: item['quantity'],
      price: item['price'],
    );
  }
}