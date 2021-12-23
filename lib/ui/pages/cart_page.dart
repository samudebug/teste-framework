import 'package:cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_repository/products_repository.dart';
import 'package:teste_framework/blocs/cart_bloc/cart_bloc.dart';
import 'package:teste_framework/blocs/product_bloc/products_bloc.dart';
import 'package:teste_framework/ui/pages/product_view.dart';
import 'package:teste_framework/ui/widgets/product_card_cart_widget.dart';
import 'dart:developer' as developer;
import 'package:pdf/widgets.dart' as pw;

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ProductsBloc>().add(LoadProducts());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Carrinho"),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            if (cartState is CartLoaded) {
              if (cartState.cart.products!.isEmpty) {
                return const Center(
                  child: Text("Nenhum produto no carrinho"),
                );
              }
              List<String> ids = cartState.cart.products!
                  .map((e) => e.id)
                  .toList()
                  .cast<String>();
              context.read<ProductsBloc>().add(LoadProductsByIds(ids));
              return BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoaded) {
                    return Column(
                      children: [
                        Expanded(
                            flex: 9,
                            child: Center(
                              child: ListView.builder(
                                itemCount: cartState.cart.products!.length,
                                itemBuilder: (context, index) {
                                  Product product = state.products[index];
                                  return Dismissible(
                                    key: Key(product.id!),
                                    onDismissed: (direction) {
                                      int productIndex = cartState
                                          .cart.products!
                                          .indexWhere((element) =>
                                              element.id == product.id);
                                      developer
                                          .log("Product Index: $productIndex");
                                      cartState.cart.products!
                                          .removeAt(productIndex);
                                      context.read<CartBloc>().add(UpdateCart(
                                          Cart(cartState.cart.id,
                                              cartState.cart.products)));
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewProductPage(
                                                      product: product,
                                                      quantity: cartState
                                                          .cart.products!
                                                          .indexWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  product.id),
                                                    ),
                                                fullscreenDialog: true));
                                      },
                                      child: ProductCartCard(
                                        product: product,
                                        quantity: cartState
                                            .cart.products![index].quantity,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Preço total:",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          "R\$ ${getTotalPrice(state.products, cartState.cart.products!.cast<ProductCart>()).toStringAsFixed(2)}",
                                          style: const TextStyle(fontSize: 24),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: ElevatedButton(
                                        child: Text("FINALIZAR COMPRA"),
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                              GeneratePDF(generatePdf(
                                                  cartState.cart.products!
                                                      .cast<ProductCart>(),
                                                  state.products)));
                                          context.read<CartBloc>().add(
                                              UpdateCart(
                                                  Cart(cartState.cart.id, [])));
                                        },
                                      ))
                                ],
                              ),
                            )),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  double getTotalPrice(List<Product> products, List<ProductCart> productsCart) {
    double result = 0;
    for (ProductCart productCart in productsCart) {
      int productIndex =
          products.indexWhere((element) => element.id == productCart.id);
      Product product = products[productIndex];
      result += product.price! * productCart.quantity!;
    }
    return result;
  }

  pw.Widget generatePdf(
      List<ProductCart> productsCart, List<Product> products) {
    final List<pw.Widget> children = [
      pw.SizedBox(
          height: 200,
          child: pw.Text("RECIBO", style: const pw.TextStyle(fontSize: 42))),
      pw.Row(children: [
        pw.Expanded(
            flex: 4,
            child: pw.Text("Produto",
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold))),
        pw.Expanded(
            flex: 2,
            child: pw.Text("Quantidade",
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold))),
        pw.Expanded(
            flex: 2,
            child: pw.Text("Valor Uni.",
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold))),
      ]),
    ];
    final List<pw.Widget> list = productsCart.map((e) {
      Product product = products.firstWhere((element) => element.id == e.id);
      return pw.Row(children: [
        pw.Expanded(
            flex: 4,
            child: pw.Text(product.name!,
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold))),
        pw.Expanded(
            flex: 2,
            child: pw.Text("x${e.quantity.toString()}",
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold))),
        pw.Expanded(
            flex: 2,
            child: pw.Text("R\$ ${product.price!.toStringAsFixed(2)}",
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold))),
      ]);
    }).toList();
    children.addAll(list);
    children.add(pw.Row(children: [
      pw.Expanded(
          flex: 6,
          child: pw.Text("TOTAL",
              style:
                  pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold))),
      pw.Expanded(
          flex: 2,
          child: pw.Text(
              "R\$ ${getTotalPrice(products, productsCart).toStringAsFixed(2)}",
              style:
                  pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold))),
    ]));
    final content = pw.Column(children: children);
    return content;
  }
}
