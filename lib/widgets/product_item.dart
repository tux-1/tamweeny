import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/generated/l10n.dart';
import 'package:tamweeny/providers/recommended_products.dart';
import 'package:tamweeny/providers/search.dart';

import '../providers/cart.dart';
import '../providers/category_products.dart';
import '../Models/product.dart';
import '../providers/products.dart';
import '../utils/lang.dart';

class ProductItem extends ConsumerWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Stack(
              children: [
                ColoredBox(
                  color: Colors.white,
                  child: SizedBox.expand(
                    child: Image.network(
                      product.productImage,
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
                if (product.discount > 0)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 0.5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffDE1010),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '-${product.discount}%',
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ColoredBox(
            color: const Color(0xff345E37),
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
                          product.productName,
                          maxLines: 2,
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
                      onPressed: () {
                        ref
                            .read(asyncProductsProvider.notifier)
                            .toggleFavoriteStatus(product.id);
                        ref
                            .read(asyncCategoryItemsProvider.notifier)
                            .toggleFavoriteStatus(product.id);

                        // to refresh the searched items
                        ref.invalidate(searchProvider);
                        for (final item
                            in ref.read(recommendedProductsProvder).value ??
                                []) {
                          if (product.id == item.id) {
                            ref.invalidate(recommendedProductsProvder);
                          }
                        }
                      },
                      padding: EdgeInsets.zero,
                      icon: product.favoriteStats
                          ? const Icon(
                              Icons.favorite,
                              color: Color(0xffFF0000),
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
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
                          '${S.of(context).price} ${product.sellingPrice.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0xffE4EFCD),
                        borderRadius: BorderRadius.only(
                          topRight: Language.isArabic()
                              ? const Radius.circular(22)
                              : Radius.zero,
                          topLeft: Language.isArabic()
                              ? Radius.zero
                              : const Radius.circular(22),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          ref
                              .read(asyncCartProvider.notifier)
                              .postCartItem(
                                productId: product.id,
                                isAdding: true,
                              )
                              .then(
                            (value) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              return ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(S.of(context).added_to_cart),
                                ),
                              );
                            },
                          );
                        },
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.add_circle_outline_outlined,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(curve: Curves.easeIn, delay: Durations.short1);
  }
}
