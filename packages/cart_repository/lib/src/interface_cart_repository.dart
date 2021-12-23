import 'package:cart_repository/src/models/cart.dart';

abstract class ICartRepository {
  Future<Cart> getCart(String id);
  Future<Cart> updateCart(String id, Cart cart);
  Stream<Cart> getCartStream(String id);
}
