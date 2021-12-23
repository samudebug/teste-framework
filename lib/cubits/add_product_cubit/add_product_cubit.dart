import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as developer;
part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(int quantity) : super(AddProductState(quantity));

  double getTotalPrice(double price) {
    return price * state.quantity;
  }

  void increaseQuantity() {
    int newQuantity = state.quantity + 1;

    emit(state.copyWith(quantity: newQuantity));
  }

  void decreaseQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }
}
