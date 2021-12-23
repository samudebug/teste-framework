class Product {
  String? id;
  String? name;
  String? imageUrl;
  double? price;
  int? rating;

  Product(this.id, this.name, this.imageUrl, this.price, this.rating);

  Product.fromJson(dynamic data)
      : id = data.id,
        name = data['name'],
        imageUrl = data['imageUrl'],
        price = data['price'],
        rating = data['rating'];
}
