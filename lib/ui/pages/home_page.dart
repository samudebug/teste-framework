import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:products_repository/products_repository.dart';
import 'package:teste_framework/blocs/cart_bloc/cart_bloc.dart';
import 'package:teste_framework/blocs/product_bloc/products_bloc.dart';
import 'package:teste_framework/ui/pages/cart_page.dart';
import 'package:teste_framework/ui/pages/product_view.dart';
import 'package:teste_framework/ui/widgets/product_card_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ProductsBloc>().add(LoadProducts());
    context.read<CartBloc>().add(LoadCart());
    searchBar = SearchBar(
        setState: setState,
        inBar: true,
        onSubmitted: (value) {
          context.read<ProductsBloc>().add(SearchProducts(value));
        },
        hintText: "Pesquisa",
        buildDefaultAppBar: (context) => AppBar(
              title: const Center(
                child: Text("Teste Framework"),
              ),
              actions: [searchBar.getSearchAction(context)],
            ));
    super.initState();
  }

  late SearchBar searchBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            if (state.cart.products!.isNotEmpty) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage(),
                          fullscreenDialog: true));
                },
                child: Badge(
                  badgeContent: Text('${state.cart.products!.length}'),
                  child: const Icon(Icons.shopping_cart),
                ),
              );
            }
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartPage(),
                        fullscreenDialog: true));
              },
              child: const Icon(Icons.shopping_cart),
            );
          }
          return Container();
        },
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsInitial || state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductsLoaded) {
            return Center(
                child: ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                Product product = state.products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewProductPage(product: product),
                            fullscreenDialog: true));
                  },
                  child: ProductCardWidget(
                    product: product,
                  ),
                );
              },
            ));
          }
          return Container();
        },
      ),
    );
  }
}
