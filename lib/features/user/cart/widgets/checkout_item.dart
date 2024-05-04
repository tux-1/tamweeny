import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Models/cart_item.dart';
import '../../../../providers/cart.dart';

class CheckoutItem extends ConsumerWidget {
  const CheckoutItem({super.key, required this.cartItem});
  final CartItem cartItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xff335145),
        borderRadius: BorderRadius.circular(21),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  cartItem.productName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  children: [
                    IconButton(
                      onPressed: () {
                        ref.read(asyncCartProvider.notifier).postCartItem(
                              productId: cartItem.productId,
                              isAdding: true,
                            );
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      cartItem.quantity.toString(),
                      style: const TextStyle(
                        color: Color(0xffDEA568),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(asyncCartProvider.notifier)
                            .postCartItem(
                              productId: cartItem.productId,
                              isAdding: false,
                            )
                            .then((value) => null)
                            .onError((error, stackTrace) => null);
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.white,
                      ),
                    ),
                    Text(cartItem.totalPrice.toString()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          // Image
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: 100,
            width: 120,
            child: Image.network(
              cartItem.productImage,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
