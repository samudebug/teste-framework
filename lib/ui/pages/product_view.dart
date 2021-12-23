import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:products_repository/products_repository.dart';
import 'package:teste_framework/blocs/cart_bloc/cart_bloc.dart';
import 'package:teste_framework/cubits/add_product_cubit/add_product_cubit.dart';

class ViewProductPage extends StatelessWidget {
  ViewProductPage({Key? key, required this.product, this.quantity})
      : super(key: key);
  final Product product;
  late AddProductCubit _cubit;
  final int? quantity;
  @override
  Widget build(BuildContext context) {
    _cubit = AddProductCubit(quantity ?? 1);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Scaffold(
            appBar: AppBar(title: Text(product.name!)),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Image.network(
                        product.imageUrl!,
                        width: 240,
                        height: 240,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          product.name!,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              const Center(
                                child: Text(
                                  "Avaliação",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Center(
                                child: RatingBarIndicator(
                                  rating: product.rating!.toDouble(),
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemSize: 50,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Preço",
                            style: TextStyle(fontSize: 24),
                          ),
                          BlocBuilder<AddProductCubit, AddProductState>(
                            bloc: _cubit,
                            builder: (context, state) => Text(
                              "R\$ ${_cubit.getTotalPrice(product.price!).toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 24),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Quantidade",
                            style: TextStyle(fontSize: 24),
                          ),
                          BlocBuilder<AddProductCubit, AddProductState>(
                            bloc: _cubit,
                            builder: (context, state) {
                              return SizedBox(
                                width: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          _cubit.decreaseQuantity();
                                        },
                                        icon: const Icon(Icons.remove)),
                                    Text(
                                      state.quantity.toString(),
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _cubit.increaseQuantity();
                                        },
                                        icon: const Icon(Icons.add))
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: () {
                          int index = state.cart.products!.indexWhere(
                              (element) => element.id == product.id);
                          if (index != -1) {
                            state.cart.products![index] =
                                ProductCart(product.id, _cubit.state.quantity);
                          } else {
                            state.cart.products!.add(
                                ProductCart(product.id, _cubit.state.quantity));
                          }
                          context.read<CartBloc>().add(UpdateCart(state.cart));
                          Navigator.pop(context);
                        },
                        child: const Text("ADICIONAR AO CARRINHO"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
