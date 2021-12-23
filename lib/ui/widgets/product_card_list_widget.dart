import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:products_repository/products_repository.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(flex: 2, child: Image.network(product.imageUrl!)),
            Expanded(
                flex: 8,
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
                            flex: 8,
                            child: RatingBarIndicator(
                              rating: product.rating!.toDouble(),
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 25,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                  "R\$ ${product.price!.toStringAsFixed(2)}"))
                        ],
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
