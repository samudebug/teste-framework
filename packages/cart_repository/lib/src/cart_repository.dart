import 'dart:async';

import 'package:cart_repository/src/interface_cart_repository.dart';
import 'package:cart_repository/src/models/cart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:realtime_database_repository/realtime_database_repository.dart';

class CartRepository implements ICartRepository {
  final IRealtimeDatabaseRepository _repository;
  final StreamController<Cart> _controller = StreamController<Cart>();
  CartRepository(IRealtimeDatabaseRepository repository)
      : _repository = repository;

  @override
  Future<Cart> getCart([String id = '']) async {
    DatabaseReference ref = _repository.getRef(id);
    DataSnapshot data = await ref.get();
    Cart cart;
    if (id.isEmpty) {
      cart = await updateCart(ref.key!, Cart(ref.key, []));
    } else {
      cart = Cart.fromJson(data.value);
    }
    cart.id = ref.key;
    return cart;
  }

  @override
  Future<Cart> updateCart(String id, Cart cart) async {
    DatabaseReference ref = _repository.getRef(id);
    await ref.set(cart.toJson());
    return getCart(id);
  }

  @override
  Stream<Cart> getCartStream(String id) {
    _repository.listenToRef(id).listen((event) {
      Cart cart = Cart.fromJson(event.snapshot.value);
      cart.id = event.snapshot.ref.key;
      _controller.add(cart);
    });
    return _controller.stream;
  }
}
