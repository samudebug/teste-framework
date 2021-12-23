import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:products_repository/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(IProductsRepository productsRepository)
      : super(ProductsInitial()) {
    _productsRepository = productsRepository;
    on<LoadProducts>((event, emit) {
      _productsRepository
          .getAllProducts()
          .then((value) => add(ProductsReady(value)));
      emit(ProductsLoading());
    });
    on<ProductsReady>((event, emit) => emit(ProductsLoaded(event.products)));
    on<LoadProductsByIds>((event, emit) {
      _productsRepository
          .getProductsById(event.ids)
          .then((value) => add(ProductsReady(value)));
      emit(ProductsLoading());
    });

    on<SearchProducts>((event, emit) {
      _productsRepository
          .searchProducts(event.query)
          .then((value) => add(ProductsReady(value)));
      emit(ProductsLoading());
    });
  }
  late IProductsRepository _productsRepository;
}
