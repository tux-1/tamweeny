import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Models/cart_item.dart';
import '../../../providers/cart.dart';

class CheckoutItem extends ConsumerWidget {
  const CheckoutItem({super.key, required this.cartItem});
  final CartItem cartItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.black,
        ),
      ),
      key: Key(cartItem.id.toString()),
      child: Column(
        children: [
          Row(
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
                            ref.read(asyncCartProvider.notifier).postCartItem(
                                  productId: cartItem.productId,
                                  isAdding: false,
                                );
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

              // Image
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: 85,
                width: 85,
                child: Image.network(
                  'https://media.istockphoto.com/id/153737841/photo/rice.jpg?s=612x612&w=0&k=20&c=lfO7iLT0UsDDzra0uBOsN1rvr2d5OEtrG2uwbts33_c=',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(endIndent: 15, indent: 15),
        ],
      ),
    );
  }
}
