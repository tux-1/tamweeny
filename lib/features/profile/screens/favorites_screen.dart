import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/generated/l10n.dart';

import '../../../widgets/product_item.dart';
import '../providers/favorites.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});
  static const routeName = 'account-favorites';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesData = ref.watch(favoritesProvider.future);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).favorite_products,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: FutureBuilder(
        future: favoritesData,
        builder: (context, snapshot) {
          final favorites = snapshot.data ?? [];
          return GridView.builder(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 15,
            ),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 0.7,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              maxCrossAxisExtent: 300,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return ProductItem(favorites[index]);
            },
          );
        },
      ),
    );
  }
}
