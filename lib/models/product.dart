class Product {
  final int? id;
  final String name;
  final double price;
  final String image;
  final String? checkoutId;

  Product(
      {this.id,
      required this.name,
      required this.price,
      required this.image,
      this.checkoutId});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        image: json['image'],
        checkoutId: json['checkoutId']);
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'image': image,
        'checkoutId': checkoutId
      };
}
