import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/categories.dart';
import '../../../providers/category_products.dart';
import '../../../providers/filters.dart';
import '../../../widgets/product_item.dart';
import 'widgets/category_card.dart';
import 'widgets/category_chips.dart';
import '../../../widgets/custom_search_bar.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chosenCategory = ref.watch(filtersProvider).chosenCategory;
    final categories = ref.watch(categoriesFutureProvider).value ?? [];
    final categoryItems = ref.watch(asyncCategoryItemsProvider).value ?? [];

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      controller: scrollController,
      slivers: chosenCategory == null
          ? [
              const CustomSearchBar(),
              SliverPadding(
                padding: const EdgeInsets.only(top: 11),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: categories[index],
                    );
                  },
                ),
              ),
            ]
          : [
              const CustomSearchBar(),
              SliverToBoxAdapter(
                child: CategoryChips(),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    maxCrossAxisExtent: 300,
                  ),
                  itemCount: categoryItems.length,
                  itemBuilder: (context, index) {
                    return ProductItem(categoryItems[index]);
                  },
                ),
              ),
            ],
    );
  }
}
