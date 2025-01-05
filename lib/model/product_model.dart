class Product {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  bool isInCart;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.price,
      this.isInCart = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'isInCart': isInCart ? 1 : 0, // Store as 1 (true) or 0 (false)
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      // Convert the stored 1/0 to boolean (true/false)
      isInCart: map['isInCart'] == 1,
    );
  }
}
