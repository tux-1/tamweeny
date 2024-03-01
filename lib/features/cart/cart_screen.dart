import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/features/cart/widgets/checkout_item.dart';
import 'package:tamweeny/generated/l10n.dart';

import '../../providers/cart.dart';
import '../../widgets/custom_scaffold.dart';
import 'widgets/checkout_data.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartData = ref.watch(asyncCartProvider.future);
    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).shopping_cart,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: FutureBuilder(
        future: cartData,
        builder: (context, cartDataSnapshot) {
          if (cartDataSnapshot.connectionState == ConnectionState.done) {
            final checkoutItems = cartDataSnapshot.data ?? [];
            return CustomScrollView(slivers: [
              SliverList.builder(
                itemCount: checkoutItems.length,
                itemBuilder: (context, index) => CheckoutItem(
                  cartItem: checkoutItems[index],
                ),
              ),
              const CheckoutData(),
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
