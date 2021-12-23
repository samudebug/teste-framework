part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductsEvent {}

class LoadProductsByIds extends ProductsEvent {
  final List<String> ids;

  LoadProductsByIds(this.ids);

  @override
  List<Object?> get props => [ids];
}

class SearchProducts extends ProductsEvent {
  final String query;

  SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class ProductsReady extends ProductsEvent {
  final List<Product> products;
  ProductsReady(this.products);

  @override
  List<Object?> get props => [products];
}
