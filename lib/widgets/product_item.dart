import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/generated/l10n.dart';

import '../providers/product.dart';

class ProductItem extends ConsumerStatefulWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  ConsumerState<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends ConsumerState<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider<Product>((ref) => widget.product);
    final product = ref.watch(productData);

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
                  product.productName == 'ابو مهنود معلب'
                      ? 'https://cdn.discordapp.com/attachments/1080145698370113558/1209456873649078272/Mahnood.png?ex=65e6fd7d&is=65d4887d&hm=d644d0ecf864b3e7e2412eedb91cda7aadd4665cb964b81fae5b6f7af95e0829&'
                      : 'https://media.istockphoto.com/id/153737841/photo/rice.jpg?s=612x612&w=0&k=20&c=lfO7iLT0UsDDzra0uBOsN1rvr2d5OEtrG2uwbts33_c=',
                  // product.productImage,
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
                          product.productName,
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
                          '${S.of(context).unit_price} ${product.sellingPrice.toString()}',
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