part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class CartReady extends CartEvent {
  final Cart cart;
  const CartReady(this.cart);

  @override
  List<Object> get props => [cart];
}

class UpdateCart extends CartEvent {
  final Cart cart;
  const UpdateCart(this.cart);

  @override
  List<Object> get props => [cart];
}

class GeneratePDF extends CartEvent {
  final pw.Widget content;
  const GeneratePDF(this.content);

  @override
  List<Object> get props => [content];
}
