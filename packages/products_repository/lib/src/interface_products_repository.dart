import 'package:products_repository/src/models/product.dart';

abstract class IProductsRepository {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(String id);
  Future<List<Product>> getProductsById(List<String> ids);
  Future<List<Product>> searchProducts(String value);
}
