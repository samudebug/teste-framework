import 'package:flutter/material.dart';
import 'package:products_repository/products_repository.dart';

class ProductCartCard extends StatelessWidget {
  ProductCartCard({Key? key, required this.product, required this.quantity})
      : super(key: key);
  Product product;
  int quantity;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(flex: 2, child: Image.network(product.imageUrl!)),
            Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                              product.name!,
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                  "R\$ ${product.price!.toStringAsFixed(2)}"))
                        ],
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text("Quantidade"),
                      ),
                      Center(
                        child: Text(
                          "x$quantity",
                          style: const TextStyle(fontSize: 24),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
