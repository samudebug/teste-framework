import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:products_repository/src/interface_products_repository.dart';
import 'package:products_repository/src/models/product.dart';
import 'dart:developer' as developer;

class ProductsRepository implements IProductsRepository {
  late final IFirestoreRepository _repository;
  ProductsRepository(IFirestoreRepository repository)
      : _repository = repository;
  @override
  Future<List<Product>> getAllProducts() async {
    List<QueryDocumentSnapshot> docs =
        await _repository.getAllDocuments('products');

    return docs.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<Product> getProductById(String id) async {
    DocumentSnapshot doc = await _repository.getDocumentById("products", id);
    return Product.fromJson(doc);
  }

  @override
  Future<List<Product>> getProductsById(List<String> ids) async {
    List<Product> result = [];
    developer.log("$ids");
    for (String id in ids) {
      result.add(await getProductById(id));
    }
    return result;
  }

  @override
  Future<List<Product>> searchProducts(String value) async {
    List<QueryDocumentSnapshot> docs =
        await _repository.getAllDocuments('products');
    List<Product> products =
        docs.map((e) => Product.fromJson(e)).toList().cast<Product>();
    if (value.isEmpty) {
      return products;
    }
    return products
        .where((element) => element.name!.startsWith(value))
        .toList();
  }
}
