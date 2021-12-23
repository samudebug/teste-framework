class Cart {
  String? id;
  List? products;

  Cart(this.id, this.products);

  Cart.fromJson(dynamic data) {
    if (data['products'] != null) {
      products = data['products'].map((e) => ProductCart.fromJson(e)).toList();
    } else {
      products = [];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products?.map((e) => e.toJson()).toList(),
    };
  }

  Cart copyWith({String? id, List<ProductCart>? products}) {
    return Cart(id ?? this.id, products ?? this.products);
  }
}

class ProductCart {
  String? id;
  int? quantity;

  ProductCart(this.id, this.quantity);

  ProductCart.fromJson(dynamic data)
      : id = data['id'],
        quantity = data['quantity'];

  Map<String, dynamic> toJson() {
    return {'id': id, 'quantity': quantity};
  }
}
