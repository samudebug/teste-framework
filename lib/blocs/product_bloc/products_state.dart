part of 'products_bloc.dart';

@immutable
abstract class ProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  ProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}
