import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    // final deviceSize = MediaQuery.of(context).size;
    return Center(
      child: Card(
        color: Color.fromARGB(255, 224, 224, 224),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                        child: Text(
                      "Couldn't load image",
                      textAlign: TextAlign.center,
                    ));
                  },
                ),
              ),
              Container(
                constraints: const BoxConstraints(minWidth: double.maxFinite),
                height: 87,
                color: Color(0xff1E352F),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        maxLines: 2,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.05,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          product.price.toString(),
                        ),
                        Text(product.subtitle == null
                            ? ''
                            : product.subtitle.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// IconButton(
                      //   onPressed: () {
                      //     product.setFavValue(!product.isFavorite);
                      //   },
                      //   icon: Icon(product.isFavorite
                      //       ? Icons.favorite
                      //       : Icons.favorite_border),
                      // ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.add),
                      // ),
                      // Text(
                      //   '5',
                      // ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.remove),
                      // ),