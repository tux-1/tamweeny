import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamweeny/generated/l10n.dart';

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: ColoredBox(
              color: Colors.white,
              child: SizedBox.expand(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
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
            ),
          ),
          ColoredBox(
            color: const Color(0xffDEA568).withOpacity(0.85),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 0,
                        ),
                        child: Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.favorite_border, color: Colors.white),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 0,
                        ),
                        child: Text(
                          '${S.of(context).unit_price} ${product.price.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.add_box_outlined, color: Colors.white),
                    )
                  ],
                ),
                Center(
                  child: Text(
                    S.of(context).remaining,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: const Color(0xff335145)),
                  ),
                )
              ],
            ),
          ),
        ],
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