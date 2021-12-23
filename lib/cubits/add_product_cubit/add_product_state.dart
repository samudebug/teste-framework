part of 'add_product_cubit.dart';

class AddProductState extends Equatable {
  int quantity;
  AddProductState(this.quantity);

  AddProductState copyWith({int? quantity}) {
    return AddProductState(quantity ?? this.quantity);
  }

  @override
  List<Object> get props => [quantity];
}
